FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

AVB_ROOT_HASH_SIGN ?= "0"

SRC_URI += "${@bb.utils.contains("IMAGE_CLASSES", "avb-verity", \
           " file://dm-verity.cfg", "" ,d)}"

SRC_URI += "${@bb.utils.contains("IMAGE_CLASSES", "avb-verity", \
           bb.utils.contains("AVB_ROOT_HASH_SIGN", "1", \
           " file://dm-verity-verify.cfg \
             file://v6.18/0001-dm-verity-add-CONFIG_DM_VERITY_REQUIRE_ROOTHASH_SIG.patch \
             file://v6.18/0002-dm-verity-add-root_hash_sig_hex-optional-parameter.patch \
             file://v6.18/0003-params-raise-charp-parameter-length-limit.patch" \
            , "" ,d), "" ,d)}"

KERNEL_TRUSTED_KEYS:append = "${@bb.utils.contains("IMAGE_CLASSES", "avb-verity", \
           bb.utils.contains("AVB_ROOT_HASH_SIGN", "1", \
           " ${AVB_X509}", "" ,d), "" ,d)}"
inherit ${@bb.utils.contains("AVB_ROOT_HASH_SIGN", "1", "kernel-trusted-keys", "", d)}
