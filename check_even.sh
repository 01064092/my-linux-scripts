read -p "Enter a number: " number

# Check if input is a valid integer
if [[ "$number" =~ ^-?[0-9]+$ ]]; then
    if [ $((number % 2)) -eq 0 ]; then
        echo "$number is even"
    else
        echo "$number is odd"
    fi
else
    echo "Error: '$number' is not a valid integer."
    exit 1
fi
