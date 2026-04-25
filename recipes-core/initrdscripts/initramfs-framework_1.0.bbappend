require ${@bb.utils.contains('IMAGE_CLASSES', 'avb-verity', 'initramfs-framework.inc', '', d)}
