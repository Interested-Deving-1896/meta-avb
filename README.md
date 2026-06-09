[update-readmes]   Mode: rewrite — migrating to template structure...
# meta-avb

[![Built with Ona](https://ona.com/build-with-ona.svg)](https://app.ona.com/#https://github.com/Interested-Deving-1896/meta-avb)

<!-- AI:start:what-it-does -->
_Description pending._
<!-- AI:end:what-it-does -->

## Architecture

<!-- AI:start:architecture -->
_Architecture documentation pending._
<!-- AI:end:architecture -->

## Install

<!-- Add installation instructions here. This section is yours — the AI will not modify it. -->

```bash
git clone https://github.com/Interested-Deving-1896/meta-avb.git
cd meta-avb
```

## Usage

<!-- Add usage examples here. This section is yours — the AI will not modify it. -->

## Configuration


Add the following to your `local.conf` or KAS configuration:

```
IMAGE_CLASSES += "avb-verity"
IMAGE_FEATURES += "read-only-rootfs"
INHERIT += "avb-verity-keys"
AVB_ROOT_HASH_SIGN = "1"
```

| Variable | Default | Description |
|----------|---------|-------------|
| `AVB_KEYS_DIR` | `${TMPDIR}/avb-keys` | Directory for signing keys; ephemeral keys are generated here if missing |
| `AVB_SIGN_KEY` | `${AVB_KEYS_DIR}/privkey_avb.pem` | Path to private key (PEM) for AVB signing |
| `AVB_X509` | `${AVB_KEYS_DIR}/x509_avb.pem` | Path to X.509 certificate for root hash signature |
| `AVB_ALGORITHM` | `SHA256_RSA4096` | AVB signing algorithm |
| `AVB_HASH_ALGORITHM` | `sha256` | Hash algorithm for dm-verity |
| `AVB_PARTITION_NAME` | `rootfs` | Partition name embedded in AVB footer |
| `AVB_PARTITION_SIZE` | `0` (auto) | Partition size in bytes, 0 = fit to image |
| `AVB_DATA_DEV` | `/dev/mmcblk0p2` | Block device for dm-verity data and hash (kernel cmdline path only) |
| `AVB_ROOT_HASH_SIGN` | `0` | Enable PKCS#7 root hash signing and kernel signature verification |

When `AVB_ROOT_HASH_SIGN` is set to `1`, the root hash is signed with the AVB key and
the X.509 certificate is embedded in the kernel trusted keyring. The kernel patches for
`root_hash_sig_hex` are also applied. Set to `0` to disable root has signature verification.

## CI

<!-- AI:start:ci -->
_CI documentation pending._
<!-- AI:end:ci -->

## Mirror chain

<!-- AI:start:mirror-chain -->
This repo is maintained in [`Interested-Deving-1896/meta-avb`](https://github.com/Interested-Deving-1896/meta-avb) and mirrored through:

```
Interested-Deving-1896/meta-avb  ──►  OpenOS-Project-OSP/meta-avb  ──►  OpenOS-Project-Ecosystem-OOC/meta-avb
```

Changes flow downstream automatically via the hourly mirror chain in
[`fork-sync-all`](https://github.com/Interested-Deving-1896/fork-sync-all).
Direct commits to OSP or OOC are detected and opened as PRs back to `Interested-Deving-1896`.
<!-- AI:end:mirror-chain -->

## Contributors

<!-- AI:start:contributors -->
_Contributors pending._
<!-- AI:end:contributors -->

## Origins

<!-- AI:start:origins -->
_Original project — no upstream fork._
<!-- AI:end:origins -->

## Resources

<!-- AI:start:resources -->
_No additional resource files found._
<!-- AI:end:resources -->

## License

<!-- AI:start:license -->
<!-- License not detected — add a LICENSE file to this repo. -->
<!-- AI:end:license -->
