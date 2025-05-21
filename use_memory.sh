echo "Disk usage report (highlighting partitions > 80% full):"
echo ""

# Run df -h , Skip first header Line ,check each line use percentage

df -h | tail -n +2 | while read line; do
    #Get The Use% value(like "82")
    usage=$(echo $line | awk '{print $5}' | tr -d '%' )
    
    if [$usage -gt 80]; then
        #Print in red if usage > 80%
        echo -e "\e[31m$line\e[0m"
    else
        #Normal Print
        echo "$line"
    fi
done
