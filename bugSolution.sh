#!/bin/bash

# This script demonstrates a solution to the race condition bug using a lock file.

# Create a file to store the counter value.
touch counter.txt

# Create a lock file.
touch lock.txt

# Function to increment the counter using a lock file.
increment_counter() {
  # Acquire the lock.
  while ! flock -n 2 lock.txt; do # Non-blocking lock
    sleep 0.1
  done

  # Read the current counter value.
  current_value=$(cat counter.txt)

  # Increment the counter.
  new_value=$((current_value + 1))

  # Write the new counter value back to the file.
  echo $new_value > counter.txt

  # Release the lock.
flock -u 2 lock.txt
}

# Run the increment_counter function concurrently multiple times.
for i in {1..10}; do
  increment_counter &
done

# Wait for all background processes to finish.
wait

# Print the final counter value.
echo "Final counter value: $(cat counter.txt)"