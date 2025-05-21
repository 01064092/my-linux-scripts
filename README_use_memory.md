
# Disk Usage Check Script

This Bash script checks disk usage on your system using the `df -h` command, and **highlights any partitions that are more than 80% full**. It's useful for monitoring your storage and avoiding full disks.

---

## 🧠 What It Does

- Lists all mounted partitions
- Parses the usage percentage from each line
- If a partition is above 80% usage, it highlights that line in **red**
- Otherwise, it prints the line normally

---

## 💻 Script: `disk_usage_check.sh`

```bash
#!/bin/bash

echo "Disk usage report (highlighting partitions > 80% full):"
echo ""

# Run df -h and skip the header
df -h | tail -n +2 | while read line; do
    # Get the usage percent from the 5th column (like 82%)
    usage=$(echo $line | awk '{print $5}' | tr -d '%')

    # If usage is greater than 80
    if [ $usage -gt 80 ]; then
        # Print the line in red
        echo -e "\e[31m$line\e[0m"
    else
        # Print normally
        echo "$line"
    fi
done
