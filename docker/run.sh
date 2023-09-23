#!/bin/bash

# Mount the volume to /input (may need to be adjusted)
docker run -it --rm -v $(pwd):/input my-lilypad-docker:latest --model_file /input/model --data_dir /input/data
