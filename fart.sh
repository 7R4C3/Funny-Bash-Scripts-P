#!/bin/bash

# Define an array of fart sound effect file paths
fart_sounds=("fart1.wav" "fart2.wav" "fart3.wav" "fart4.wav" "fart5.wav")

# Generate a random index to select a fart sound effect
random_index=$((RANDOM % ${#fart_sounds[@]}))

# Play the fart sound effect using the "play" command from the "sox" package
play -q ${fart_sounds[$random_index]}
