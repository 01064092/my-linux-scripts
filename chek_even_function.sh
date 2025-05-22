#!/bin/bash

# Function to check if input is an integer
is_integer() {
    [[ "$1" =~ ^-?[0-9]+$ ]]
}

# Function to check if the integer is even or odd
check_even_odd() {
    if [ $(( $1 % 2 )) -eq 0 ]; then
        echo "$1 is even"
    else
        echo "$1 is odd"
    fi
}

# Main function
main() {
    read -p "Enter a number: " number

    if is_integer "$number"; then
        check_even_odd "$number"
    else
        echo "Error: '$number' is not a valid integer."
        exit 1
    fi
}

# Call the main function
main
