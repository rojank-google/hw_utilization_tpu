import os
import re
import json

def aggregate_js_data(input_file_path, output_file_path):
    """
    Reads a JavaScript file, aggregates data in the sysData array,
    and writes the updated content to a new JavaScript file.
    """
    try:
        with open(input_file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: Input file not found at {input_file_path}")
        return
    except Exception as e:
        print(f"Error reading file {input_file_path}: {e}")
        return

    # Extract variables using regex - this is robust for the given format
    date_str_match = re.search(r'var dateStr = "(.*?)";', content)
    machine_list_match = re.search(r'var machineList = "(.*?)";', content)
    default_system_match = re.search(r'var defaultSystem = (\[.*?\]);', content, re.DOTALL)
    default_month_match = re.search(r'var defaultMonth = (\[.*?\]);', content, re.DOTALL)
    sys_data_match = re.search(r'var sysData = (\[.*?\]);', content, re.DOTALL)

    if not all([date_str_match, machine_list_match, default_system_match, default_month_match, sys_data_match]):
        print("Error: Could not extract all required variables (dateStr, machineList, defaultSystem, defaultMonth, sysData).")
        return

    date_str = date_str_match.group(1)
    machine_list = machine_list_match.group(1)
    # Safely evaluate string representations of arrays
    default_system = json.loads(default_system_match.group(1).replace("'", '"'))
    default_month = json.loads(default_month_match.group(1).replace("'", '"'))
    sys_data = json.loads(sys_data_match.group(1).replace("'", '"'))

    if not isinstance(sys_data, list):
        print("Error: sysData is not a list after parsing.")
        return

    # --- Aggregation Logic ---
    aggregated_data = {} # Key: (identifier1, identifier2) -> { sum_values: [], count: int }

    for row in sys_data:
        if not isinstance(row, list) or len(row) < 6:
            print(f"Skipping malformed row: {row}")
            continue

        identifier1 = row[0] # e.g., 'Overall', 'DayTime'
        identifier2 = row[1] # e.g., 'ALL', 'cca-emu'
        # month = row[2] # Not directly used for grouping, but part of original row

        key = (identifier1, identifier2)

        if key not in aggregated_data:
            # Initialize sums for the numerical columns (index 3, 4, 5)
            aggregated_data[key] = {'sum_values': [0.0] * (len(row) - 3), 'count': 0}

        # Add numerical values to sums (assuming they are numbers)
        for i in range(3, len(row)):
            try:
                aggregated_data[key]['sum_values'][i - 3] += float(row[i])
            except ValueError:
                print(f"Warning: Non-numeric value found at row index {i} for key {key}. Skipping value.")
                # Handle non-numeric values gracefully, e.g., by skipping or defaulting to 0
                pass # Or set to 0.0 if you want to average as 0 for non-numeric

        aggregated_data[key]['count'] += 1

    new_aggregate_rows = []
    for key, data_info in aggregated_data.items():
        identifier1, identifier2 = key
        count = data_info['count']
        sum_values = data_info['sum_values']

        if count > 0:
            avg_values = [round(val / count, 4) for val in sum_values] # Round to 4 decimal places

            # The third element should be 'All Months', and the last element is always 0
            new_aggregate_rows.append([identifier1, identifier2, 'All Months'] + avg_values[:-1] + [0])
        else:
            print(f"Warning: No data found for key {key} to average.")

    # Combine original data with the new aggregate rows
    updated_sys_data = sys_data + new_aggregate_rows

    # Reconstruct the JavaScript file content
    # Use single quotes for consistency with original file for string elements in sysData
    # json.dumps converts lists of strings to double quotes, so we need to replace
    sys_data_js_string = json.dumps(updated_sys_data, indent=2)
    # Replace double quotes around string array elements with single quotes for JS compatibility
    sys_data_js_string = re.sub(r'\"(\w+)\"', r"'\1'", sys_data_js_string)

    output_content = f"""var dateStr = "{date_str}";
var machineList = "{machine_list}";
var defaultSystem = {json.dumps(default_system).replace('"', "'")};
var defaultMonth = {json.dumps(default_month).replace('"', "'")};
var sysData = {sys_data_js_string};
"""

    try:
        os.makedirs(os.path.dirname(output_file_path), exist_ok=True)
        with open(output_file_path, 'w', encoding='utf-8') as f:
            f.write(output_content)
        print(f"Successfully generated aggregated data to '{output_file_path}'")
    except Exception as e:
        print(f"Error writing output file {output_file_path}: {e}")

# --- Script Execution ---
if __name__ == "__main__":
    script_dir = os.path.dirname(__file__)
    input_file = os.path.join(script_dir, '.tmp', '.data1.js')
    output_file = os.path.join(script_dir, '.tmp', '.data1_aggregated.js') # Output to a new file

    aggregate_js_data(input_file, output_file)
