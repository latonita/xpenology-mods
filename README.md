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
