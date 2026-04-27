FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

AVB_ROOT_HASH_SIGN ?= "0"

SRC_URI += "${@bb.utils.contains("IMAGE_CLASSES", "avb-verity", \
           " file://dm-verity.cfg", "" ,d)}"

SRC_URI += "${@bb.utils.contains("IMAGE_CLASSES", "avb-verity", \
           bb.utils.contains("AVB_ROOT_HASH_SIGN", "1", \
           " file://dm-verity-verify.cfg \
             file://0001-dm-verity-add-root_hash_sig_hex-optional-parameter.patch \
             file://0002-params-raise-charp-parameter-length-limit.patch" \
            , "" ,d), "" ,d)}"

KERNEL_TRUSTED_KEYS:append = "${@bb.utils.contains("IMAGE_CLASSES", "avb-verity", \
           bb.utils.contains("AVB_ROOT_HASH_SIGN", "1", \
           " ${AVB_X509}", "" ,d), "" ,d)}"
inherit ${@bb.utils.contains("AVB_ROOT_HASH_SIGN", "1", "kernel-trusted-keys", "", d)}
