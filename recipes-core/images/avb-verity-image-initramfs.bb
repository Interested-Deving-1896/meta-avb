DESCRIPTION = "Simple initramfs image for mounting the rootfs over the verity device mapper uising AVB."

inherit core-image

IMAGE_FEATURES = ""
IMAGE_LINGUAS = ""
IMAGE_NAME_SUFFIX ?= ""

PACKAGE_INSTALL = " \
    base-files \
    base-passwd \
    busybox \
    avb-utils \
    libdevmapper \
    initramfs-module-avb-verity \
    initramfs-module-udev \
    udev \
    util-linux-mount \
    "

IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"
