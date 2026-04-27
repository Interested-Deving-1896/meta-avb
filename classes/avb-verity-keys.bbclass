# SPDX-License-Identifier: MIT
# Copyright (C) 2026 Embetrix Embedded Systems Solutions <ayoub.zaki@embetrix.com>
#
# Ephemeral signing key generation:
# If the expected AVB signing keys are missing, generate them
# under a fixed path in TMPDIR.
#

AVB_KEYS_DIR ?= "${TMPDIR}/avb-keys"
AVB_SIGN_KEY ?= "${AVB_KEYS_DIR}/privkey_avb.pem"
AVB_X509     ?= "${AVB_KEYS_DIR}/x509_avb.pem"

addhandler avb_check_signing_keys
avb_check_signing_keys[eventmask] = "bb.event.BuildStarted"

python avb_check_signing_keys() {

    import os

    d = e.data

    key_defs = [
        ('AVB_SIGN_KEY',  'rsa'),
        ('AVB_X509',      'pem'),
    ]

    keys = [(n, d.getVar(n), t) for n, t in key_defs]

    missing = [(n, p, t) for n, p, t in keys if not p or not os.path.isfile(p)]
    if not missing:
        return

    for name, path, ktype in missing:
        if not path:
            bb.fatal("%s is not set" % name)
        bb.utils.mkdirhier(os.path.dirname(path))
        if ktype == 'rsa':
            _gen_privkey(path)
        else:
            _gen_cert(name, path, keys, ktype)

    bb.warn("Dev build: generated ephemeral signing keys:\n  AVB_SIGN_KEY = %s\n  AVB_X509 = %s" % (d.getVar('AVB_SIGN_KEY'), d.getVar('AVB_X509')))
}

def _gen_privkey(path):
    import subprocess, os
    subprocess.check_call(['openssl', 'genpkey', '-algorithm', 'RSA',
                           '-pkeyopt', 'rsa_keygen_bits:4096', '-out', path])
    os.chmod(path, 0o600)

def _gen_cert(cert_name, cert_path, keys, fmt):
    import subprocess, tempfile, os
    cert_to_key = {'AVB_X509': 'AVB_SIGN_KEY'}
    privkey_name = cert_to_key.get(cert_name)
    if not privkey_name:
        bb.fatal("No private key mapping for %s — add it to cert_to_key" % cert_name)
    privkey = next((p for n, p, _ in keys if n == privkey_name and p and os.path.isfile(p)), None)
    if not privkey:
        bb.fatal("Cannot generate %s: private key %s not found" % (cert_name, privkey_name))
    outform = fmt.upper()
    cnf = None
    try:
        with tempfile.NamedTemporaryFile(mode='w', suffix='.cnf', delete=False) as f:
            f.write("[req]\n"
                    "distinguished_name=dn\n"
                    "x509_extensions=v3\n"
                    "prompt=no\n"
                    "[dn]\n"
                    "CN=avb dev\n"
                    "O=Embetrix\n"
                    "[v3]\n"
                    "basicConstraints=critical,CA:FALSE\n"
                    "keyUsage=digitalSignature\n"
                    "extendedKeyUsage=critical,codeSigning\n"
                    "subjectKeyIdentifier=hash\n")
            cnf = f.name
        subprocess.check_call(['openssl', 'req', '-new', '-x509', '-sha256', '-days', '3650',
                                '-batch', '-config', cnf, '-key', privkey, '-outform', outform, '-out', cert_path])
    finally:
        if cnf:
            os.unlink(cnf)
    os.chmod(cert_path, 0o644)
