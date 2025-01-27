#!/bin/bash

# This script demonstrates a race condition bug.

# Create a file to store the counter value.
touch counter.txt

# Function to increment the counter.
increment_counter() {
  # Read the current counter value.
  current_value=$(cat counter.txt)

  # Increment the counter.
  new_value=$((current_value + 1))

  # Write the new counter value back to the file.
  echo $new_value > counter.txt
}

# Run the increment_counter function concurrently multiple times.
for i in {1..10}; do
  increment_counter & # Run in background
done

# Wait for all background processes to finish.
wait

# Print the final counter value.
echo "Final counter value: $(cat counter.txt)"