#!/usr/bin/env python3
import platform
import os
import subprocess
import socket
import psutil

def get_system_info():
    # Hostname
    hostname = socket.gethostname()

    # Operating System
    os_info = platform.system() + " " + platform.release()

    # Uptime
    uptime = subprocess.check_output("uptime -p", shell=True).decode().strip()

    # Kernel Version
    kernel_version = platform.uname().release

    # CPU Information
    cpu_info = platform.processor()

    # Memory Information
    memory = psutil.virtual_memory()
    memory_info = f"Total Memory: {memory.total / (1024 ** 3):.2f} GB, Free Memory: {memory.available / (1024 ** 3):.2f} GB"

    # IP Addresses
    ip_addresses = [addr.address for addr in psutil.net_if_addrs().get("eth0", [])]

    # Filesystem Utilization
    partitions = psutil.disk_partitions()
    filesystem_info = ""
    for partition in partitions:
        usage = psutil.disk_usage(partition.mountpoint)
        filesystem_info += f"{partition.device} ({partition.fstype}): {usage.percent}% used\n"

    # Last Error Log Entries
    log_file_path = "/var/log/syslog"
    error_logs = subprocess.check_output(f"grep -i 'error' {log_file_path} | tail -n 5", shell=True).decode()

    # Print gathered information
    print("-------------------------------System Information----------------------------")
    print(f"Hostname:\t\t{hostname}")
    print(f"Operating System:\t{os_info}")
    print(f"Uptime:\t\t\t{uptime}")
    print(f"Kernel Version:\t\t{kernel_version}")
    print(f"CPU Information:\t{cpu_info}")
    print(f"Memory Information:\t{memory_info}")
    print(f"IP Addresses:\t\t{', '.join(ip_addresses)}")
    print(f"Filesystem Utilization:\n{filesystem_info}")
    print(f"Last Error Log Entries:\n{error_logs}")

if __name__ == "__main__":
    get_system_info()
