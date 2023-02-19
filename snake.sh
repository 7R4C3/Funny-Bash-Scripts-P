#!/bin/bash

# Set initial variables
rows=20
columns=40
speed=0.2
score=0

# Create an empty board
board=""
for ((i=0; i<$rows; i++)); do
    for ((j=0; j<$columns; j++)); do
        board+="."
    done
    board+="\n"
done

# Create the snake and food
snake=(0 0)
food=(0 0)

# Move the snake
move_snake() {
    # Remove the last segment of the snake
    board[$snake_tail_index]="."
    
    # Move the snake's head
    case $snake_direction in
        up)
            snake_head_index=$(($snake_head_index - $columns))
            ;;
        down)
            snake_head_index=$(($snake_head_index + $columns))
            ;;
        left)
            snake_head_index=$(($snake_head_index - 1))
            ;;
        right)
            snake_head_index=$(($snake_head_index + 1))
            ;;
    esac
    
    # Add the new head to the snake
    board[$snake_head_index]="@"
    snake=($snake_head_index "${snake[@]}")
    
    # Check if the snake has eaten the food
    if [[ $snake_head_index -eq $food_index ]]; then
        score=$(($score + 1))
        generate_food
    else
        # Remove the last segment of the snake
        board[$snake_tail_index]="."
        snake=("${snake[@]:0:$snake_length}")
    fi
}

# Generate a new food item
generate_food() {
    # Find a random empty space on the board
    empty_spaces=($(echo -e "${board//[^.]/\n}" | grep -n . | cut -d: -f1))
    random_index=${empty_spaces[$((RANDOM % ${#empty_spaces[@]}))]}
    
    # Add the food to the board
    board[$random_index]="*"
    food_index=$random_index
}

# Initialize the game
generate_food
snake_head_index=0
snake_tail_index=0
snake_direction="right"
snake_length=1

# Play the game
while true; do
    # Clear the screen
    clear
    
    # Print the board and score
    printf "Score: %d\n\n" $score
    printf "$board"
    
    # Move the snake
    move_snake
    
    # Wait for the next frame
    sleep $speed
    
    # Handle user input
    read -s -n 1 key
    case $key in
        w)
            snake_direction="up"
            ;;
        s)
            snake_direction="down"
            ;;
        a)
            snake_direction="left"
            ;;
        d)
            snake_direction="right"
            ;;
    esac
done
