# Use the official Python Alpine image as the base image
FROM python:3.15.0a6-alpine3.23 AS base

# Update Alpine package index and install necessary packages
# ffmpeg: for handling video/audio streams
# libxslt-dev and libxml2-dev: for XML parsing and processing
RUN apk update && apk add --no-cache ffmpeg libxslt-dev libxml2-dev

# Create a 'builder' stage to compile dependencies
FROM base AS builder

# Install build dependencies (GCC and musl-dev for compiling)
RUN apk add --no-cache --virtual .build-deps gcc musl-dev

# Build the Streamlink wheel and store it in a specified directory
RUN pip wheel --wheel-dir=/root/wheels streamlink

# Begin the final stage, using the base image
FROM base

# Create a non-root user and group
RUN addgroup -S streamlink && adduser -S streamlink -G streamlink

# Copy the compiled wheels from the builder stage into the final image
COPY --from=builder /root/wheels /root/wheels

# Install the compiled Streamlink package without the need for internet access
RUN pip install --no-index --find-links=/root/wheels streamlink

# Switch to the non-root user
USER 1000

# Define the entry point for the container to execute Streamlink
ENTRYPOINT ["/usr/local/bin/streamlink"]
