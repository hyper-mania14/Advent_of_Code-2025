input_path = 'range_end.memh'
output_path = 'range_end_sorted.memh' #file names
def sort_memh_file(input_path, output_path):
    with open(input_path, 'r') as infile:
        lines = [line.strip() for line in infile if line.strip()]
    # Sort by integer value of hex
    lines.sort(key=lambda x: int(x, 16))
    with open(output_path, 'w') as outfile:
        for line in lines:
            outfile.write(f"{line}\n")

sort_memh_file(input_path, output_path)