# Use the official Python Alpine image as the base image
FROM alpine

RUN apk update && apk add --no-cache streamlink

# Create a non-root user and group
RUN addgroup -g 1000 streamlink && \
    adduser -u 1000 -D -G streamlink streamlink


# Switch to the non-root user
USER 1000

# Define the entry point for the container to execute Streamlink
ENTRYPOINT ["/usr/local/bin/streamlink"]
