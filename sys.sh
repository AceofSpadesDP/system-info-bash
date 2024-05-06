#!/bin/bash

# Output file
output_file="system_info.txt"

# Function to get IP information
get_ip_info() {
    echo "IP Information:" >> "$output_file"
    echo "-----------------" >> "$output_file"
    ip addr show >> "$output_file"
    echo "" >> "$output_file"
}

# Function to get filesystem utilization
get_fs_utilization() {
    echo "Filesystem Utilization:" >> "$output_file"
    echo "-----------------------" >> "$output_file"
    df -h >> "$output_file"
    echo "" >> "$output_file"
}

# Function to get last five lines of log file containing "error"
get_error_logs() {
    echo "Last five lines of log file containing 'error':" >> "$output_file"
    echo "----------------------------------------------" >> "$output_file"
    grep -i "error" /var/log/syslog | tail -n 5 >> "$output_file"
    echo "" >> "$output_file"
}

# Function to gather system information
gather_system_info() {
    # System Hostname
    hostname=$(hostname)
    echo "System Hostname: $hostname" > "$output_file"

    # Operating System
    os=$(lsb_release -d | awk -F"\t" '{print $2}')
    echo "Operating System: $os" >> "$output_file"

    # Uptime
    uptime=$(uptime -p)
    echo "System Uptime: $uptime" >> "$output_file"

    # Linux Kernel Version
    kernel=$(uname -r)
    echo "Linux Kernel Version: $kernel" >> "$output_file"

    # General CPU information
    cpu_info=$(lscpu)
    echo "CPU Information:" >> "$output_file"
    echo "$cpu_info" >> "$output_file"
    echo "" >> "$output_file"

    # General memory information
    mem_info=$(free -h)
    echo "Memory Information:" >> "$output_file"
    echo "$mem_info" >> "$output_file"
    echo "" >> "$output_file"

    # IP information
    get_ip_info

    # Filesystem utilization
    get_fs_utilization

    # Last five lines of log file containing "error"
    get_error_logs

    echo "System information has been collected and saved to $output_file"
}


