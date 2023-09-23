import os
import argparse

"""
This is a POC training program.

The train.py script is designed to take two optional command-line parameters, 
- model_file 
- data_dir
with default values of "model" and "./data" respectively. 

It appends the filenames of all the files in the specified data_dir to the model_file. 
The script first retrieves a list of filenames from the specified directory, and then
it opens the model_file in append mode and writes each filename on a new line.

E.g. python train.py --model_file model --data_dir ./data

"""

def print_file_contents(file_path):
    try:
        with open(file_path, 'r') as file:
            contents = file.read()
            print(contents)
    except FileNotFoundError:
        print(f"File not found: {file_path}")
    except Exception as e:
        print(f"An error occurred while reading the file: {str(e)}")

def append_filenames_to_model(model_file="model", data_dir="./data"):
    filenames = os.listdir(data_dir)

    with open(model_file, "a") as model_out:
        for filename in filenames:
            # Append each filename to the model file
            model_out.write(filename + "\n")



if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Append filenames from a directory to a model file."
    )

    parser.add_argument(
        "--model_file",
        default="model",
        help="Path to the model file (default: model)",
    )
    parser.add_argument(
        "--data_dir",
        default="./data",
        help="Path to the data directory (default: ./data)",
    )

    args = parser.parse_args()
    print("Before training:")
    print_file_contents(args.model_file)
    append_filenames_to_model(args.model_file, args.data_dir)
    print("After:")
    print_file_contents(args.model_file)
