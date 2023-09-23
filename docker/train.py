import os
import argparse

"""
This is a POC training program.

The train.py script is designed to take two optional command-line parameters, 
- model_file 
- data_dir
with default values of "model.in" and "./data" respectively. 

It appends the filenames of all the files in the specified data_dir to the model_file. 
The script first retrieves a list of filenames from the specified directory, and then
it opens the model_file in append mode and writes each filename on a new line.

E.g. python train.py --model_file model.in --data_dir ./data

"""


def append_filenames_to_model(model_file="model.in", data_dir="./data"):
    # Get a list of filenames in the specified directory
    filenames = os.listdir(data_dir)

    # Open the model file for appending
    with open(model_file, "a") as model_out:
        for filename in filenames:
            # Append each filename to the model file
            model_out.write(filename + "\n")


if __name__ == "__main__":
    # Create an argument parser
    parser = argparse.ArgumentParser(
        description="Append filenames from a directory to a model file."
    )

    # Define the default values for the arguments
    parser.add_argument(
        "--model_file",
        default="model.in",
        help="Path to the model file (default: model.in)",
    )
    parser.add_argument(
        "--data_dir",
        default="./data",
        help="Path to the data directory (default: ./data)",
    )

    # Parse the command line arguments
    args = parser.parse_args()

    # Call the function to append filenames to the model file
    append_filenames_to_model(args.model_file, args.data_dir)
