FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "${@bb.utils.contains("IMAGE_CLASSES", "avb-verity", " file://dm-verity.cfg", "" ,d)}"

KERNEL_TRUSTED_KEYS:append = "${@bb.utils.contains("IMAGE_CLASSES", "avb-verity", " ${AVB_X509}", "", d)}"
inherit kernel-trusted-keys
