import pandas as pd
import json

# Read the Excel file
file_path = r"C:\Users\USER\Desktop\Devops\employee\users.xlsx"  # Path to your Excel file
data = pd.read_excel(file_path)

# Ensure the required columns exist
required_columns = ["Name", "Department"]
if not all(col in data.columns for col in required_columns):
    raise ValueError(f"Excel file must contain columns: {required_columns}")

# Convert to dictionary with sanitized keys
users_dict = {
    row["Name"].replace(" ", "").replace("-", "_"): row["Department"]
    for _, row in data.iterrows()
}

# Write to a JSON file (this will overwrite the existing file)
output_file = "users.json"
with open(output_file, "w") as f:
    json.dump(users_dict, f, indent=2)

print(f"User data successfully written to {output_file}")
