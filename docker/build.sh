#!/bin/bash

IMAGE_NAME="my-lilypad-docker"
TAG="latest"

# Build the Docker container
docker build -t "$IMAGE_NAME:$TAG" .

# Check if the build was successful
if [ $? -ne 0 ]; then
  echo "Docker build failed."
  exit 1
fi

echo "Docker build successful. Image: $IMAGE_NAME:$TAG"
