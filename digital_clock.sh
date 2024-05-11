#!/bin/bash

# Function to clear the screen
clear_screen() {
    printf "\033c"
}

# Function to draw the border
draw_border() {
    local cols=$(tput cols)
    local rows=$(tput lines)

    local border_row=""
    for ((i = 1; i <= cols; i++)); do
        border_row="${border_row}─"
    done

    local border=""
    for ((i = 1; i <= rows - 4; i++)); do
        border="${border}│\n"
    done

    printf "\033[1;1H┌${border_row}┐\n${border}└${border_row}┘\n"
}

# Function to display the clock
display_clock() {
    local cols=$(tput cols)
    local rows=$(tput lines)

    local time
    local hour
    local minute
    local second
    local date

    while true; do
        time=$(date +"%H:%M:%S")
        hour=${time:0:2}
        minute=${time:3:2}
        second=${time:6:2}
        date=$(date +"%A, %B %d, %Y")  # Format the date as desired

        tput cup $((rows / 2 - 1)) $((cols / 2 - 8))
        echo -e "\033[1;37m┌───────┐"
        tput cup $((rows / 2)) $((cols / 2 - 8))
        echo -e "\033[1;37m│ $hour:$minute:$second │"
        tput cup $((rows / 2 + 1)) $((cols / 2 - 8))
        echo -e "\033[1;37m└───────┘\033[0m"

        # Display the date below the clock
        tput cup $((rows / 2 + 3)) $((cols / 2 - 12))  # Adjust position as needed
        echo -e "\033[1;32m$date\033[0m"  # Change color of date to green

        sleep 1
    done
}

# Main function
main() {
    clear_screen
    draw_border
    display_clock
}

# Call the main function
main
