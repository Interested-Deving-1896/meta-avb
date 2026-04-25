# meta-avb

## Build

```
KAS_MACHINE=qemux86-64 kas build kas-avb.yml
```

## Emulation with Qemu

```
KAS_MACHINE=qemux86-64 kas shell kas-avb.yml \
                    -c 'runqemu wic ovmf kvm serialstdio nographic snapshot qemuparams="-m 1024"'
```
