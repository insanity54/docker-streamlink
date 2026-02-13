# Makefile

# Define the image name
IMAGE_NAME = insanity54/streamlink
TAG = latest

# Default target
.PHONY: all
all: build

# Build Docker image
.PHONY: build
build:
	docker build -t $(IMAGE_NAME):$(TAG) .

# CI command
.PHONY: ci
ci:
	act --secret-file .env


# Alias for CI command
.PHONY: act
act: ci
