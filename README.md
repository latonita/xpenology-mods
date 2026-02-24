# Overview
This is just a place to keep useful things for my xpenology box based on HP Microserver Gen7 N54L.

## HWMon drivers
- i2c-piix4.ko kernel module (https://github.com/fetzerch/hp-n54l-drivers)
- jc42.ko
- k10temp.ko
- w83795.ko

## Loading drivers
```
insmod i2c-piix4.ko
insmod k10temp.ko
modprobe i2c-piix4
modprobe k10temp
```

## KVM AMD support
- kvm-amd.ko - patched KVM AMD (SVM) module for DSM 6.1 kernel 3.10.102

The stock Synology kernel is compiled with `CONFIG_CPU_SUP_AMD=n`, so `boot_cpu_data.x86_vendor`
is never set to AMD. The stock `cpu_has_svm()` check fails with "not amd" even on genuine AMD CPUs.

This module patches `has_svm()` in `svm.c` to check for AMD vendor directly via CPUID instruction,
bypassing the broken `boot_cpu_data`. Works on any AMD CPU with SVM (AMD-V) support.

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
