#!/bin/bash

# Variables
INPUT_FILE="C:\Users\USER\Desktop\Devops\employee\users.csv"  # Path to the Excel file
OUTPUT_FILE="users.json" # Output JSON file

# Check if the input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: Input file '$INPUT_FILE' not found!"
  exit 1
fi
# Process CSV into JSON
echo "Processing CSV into JSON..."
jq -Rn '
  (input | split(",") | {header: ., rows: []}) as $data
  | reduce inputs as $row (
      $data;
      .rows += [[$row | split(",")]]
    )
  | {
      users: (
        .rows[1:] | map(
          {
            (.[$data.header[0]]): .[$data.header[1]]
          }
        )
        | add
      )
    }
' users.csv > "$OUTPUT_FILE"

# Verify the JSON file creation
if [[ $? -eq 0 ]]; then
  echo "User data successfully written to '$OUTPUT_FILE'."
else
  echo "Error: Failed to generate JSON."
  exit 1
fi

# Cleanup
rm users.csv
echo "Temporary files cleaned up."

exit 0
