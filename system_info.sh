#!/bin/bash

hostname=$(hostname)

os=$(lsb_release -d | cut -f2)

# Uptime
uptime=$(uptime -p)

kernel=$(uname -r)

cpu_info=$(lscpu)

memory_info=$(free -h)

ip_info=$(ip addr)

filesystem_info=$(df -h)

error_log=$(grep -i "error" /var/log/syslog | tail -n 5)

output_file="/system_info.txt"
{
    echo "System Hostname: $hostname"
    echo "Operating System: $os"
    echo "Uptime: $uptime"
    echo "Linux Kernel Version: $kernel"
    echo -e "\nCPU Information:\n$cpu_info"
    echo -e "\nMemory Information:\n$memory_info"
    echo -e "\nIP Information:\n$ip_info"
    echo -e "\nFilesystem Utilization:\n$filesystem_info"
    echo -e "\nLast 5 Error Log Entries:\n$error_log"
} > "$output_file"

echo "System information saved to $output_file"
