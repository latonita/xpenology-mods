#!/bin/sh

CPU_T1=$(/opt/sbin/sensors k10temp-pci-00c3 -u | sed -n 's/temp1_input://p' | cut -d ' ' -f 4)
CPU_T2=$(/opt/sbin/sensors w83795adg-i2c-1-2f -u | sed -n 's/temp1_input://p' | cut -d ' ' -f 4)
NB_T=$(/opt/sbin/sensors w83795adg-i2c-1-2f -u | sed -n 's/temp2_input://p' | cut -d ' ' -f 4)
MB_T=$(/opt/sbin/sensors w83795adg-i2c-1-2f -u | sed -n 's/temp5_input://p' | cut -d ' ' -f 4)
RAM_T=$(/opt/sbin/sensors jc42-i2c-0-18 -u | sed -n 's/temp1_input://p' | cut -d ' ' -f 4)

/opt/bin/mosquitto_pub -t "home-iot-node/hp-n54l/temperature" -m "{\"cpu_t1\":$CPU_T1,\"cpu_t2\":$CPU_T2,\"nb\":$NB_T,\"mb\":$MB_T,\"ram\":$RAM_T}"
