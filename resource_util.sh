hostname=$1
env=$2
# Check CPU Utilization
echo "=======================" >> system_status.txt
echo "CPU Utilization:" >> system_status.txt
mpstat 1 1 | awk 'NR==4 {print "Average CPU Usage: " 100-$NF "%"}' >> system_status.txt

# Check Memory Utilization
echo "========================" >> system_status.txt
echo "Memory Utilization:" >> system_status.txt
free -m | awk 'NR==2 {printf "Used Memory: %s MB (%.2f%%)\n", $3, ($3/$2)*100}' >> system_status.txt

#Check Disk Utilization
echo "=======================" >> system_status.txt
echo "Disk Utilization:" >> system_status.txt
df -h | awk 'NR>1 {printf "%s\t%s\t%s\t%s\n", $1, $2, $5, $6}' >> system_status.txt

#Check top 5 processes by CPU usage
echo "===========================" >> system_status.txt
echo "Top 5 processes by CPU Usage:" >> system_status.txt
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -n 6 >> system_status.txt
echo "===========================" >> system_status.txt
cat system_status.txt
