#!/bin/bash

# Run intel_gpu_top and capture its output in JSON format
gpu_info=$(sudo /usr/bin/timeout -k 3 3 /usr/bin/intel_gpu_top -J)

# Remove the first 103 lines
cleaned_output=$(echo "$gpu_info" | tail -n +104)

# Validate the JSON format using jq
jq '.' <<< "$cleaned_output" >/dev/null 2>&1

# Check the exit status of jq to see if the JSON is valid
if [ $? -eq 0 ]; then
    # If it's valid JSON, echo the cleaned output
    echo "$cleaned_output"
else
    echo "Error: The output is not in valid JSON format."
fi
