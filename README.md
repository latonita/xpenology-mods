# XPenology Mods for HP MicroServer Gen7 N54L

Custom kernel modules and patches for XPenology DSM 6.1 (kernel 3.10.102) on HP MicroServer Gen7 N54L (AMD Turion II).

## HWMon drivers
- i2c-piix4.ko kernel module (https://github.com/fetzerch/hp-n54l-drivers)
- jc42.ko
- k10temp.ko
- w83795.ko

### Loading
```
insmod i2c-piix4.ko
insmod k10temp.ko
modprobe i2c-piix4
modprobe k10temp
```

## KVM AMD support

Patched `kvm-amd.ko` module enabling KVM/SVM virtualization on AMD CPUs.

### Why is this needed?

The stock Synology kernel is compiled with `CONFIG_CPU_SUP_AMD=n`, which means
`boot_cpu_data.x86_vendor` is never set to `X86_VENDOR_AMD`. As a result, the
kernel's `cpu_has_svm()` check in `virtext.h` fails with "not amd" even on
genuine AMD hardware, making it impossible to load `kvm-amd` and use hardware
virtualization.

This module patches `has_svm()` in `svm.c` to check for AMD vendor directly
via CPUID instruction, bypassing the broken `boot_cpu_data`. Works on any AMD
CPU with SVM (AMD-V) support.

Use with [synoKVM](https://github.com/bsdcpp/synoKVM) — a QEMU/libvirt/webvirtmgr
package for Synology DSM.

### Loading
```
insmod kvm-amd.ko
chmod 666 /dev/kvm
```

### Verifying
```
lsmod | grep kvm_amd
dmesg | grep -i "nested\|kvm"
```
Expected output: "Nested Virtualization enabled", "Nested Paging enabled"
