#!/usr/bin/env python3

import os

def is_relevant_file(filename):
    """
    Determine if a file is relevant (e.g., Kotlin source files).
    Modify this function to include or exclude specific files.
    """
    return filename.endswith('.lua')

def collect_files(root_dir):
    """
    Recursively collect all relevant files from the root directory.
    """
    file_list = []
    for dirpath, dirnames, filenames in os.walk(root_dir):
        # Exclude certain directories
        dirnames[:] = [d for d in dirnames if d not in ['build', '.git', '.idea', 'out']]
        for filename in filenames:
            if is_relevant_file(filename):
                full_path = os.path.join(dirpath, filename)
                file_list.append(full_path)
    return file_list

def concatenate_files(file_list, output_file):
    """
    Concatenate the contents of all files in file_list into output_file.
    """
    with open(output_file, 'w', encoding='utf-8') as outfile:
        for filepath in file_list:
            with open(filepath, 'r', encoding='utf-8') as infile:
                # Optionally include the file path as a comment or separator
                outfile.write(f'// File: {os.path.relpath(filepath)}\n')
                outfile.write(infile.read())
                outfile.write('\n\n')  # Add spacing between files

if __name__ == '__main__':
    root_dir = '.'  # Change this if your script is not in the project root
    output_file = 'context.txt'  # Name of the output file
    files = collect_files(root_dir)
    concatenate_files(files, output_file)
    print(f'Collected {len(files)} files into {output_file}')
