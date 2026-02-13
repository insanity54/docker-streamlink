# docker-streamlink

https://github.com/insanity54/docker-streamlink

Dockerized streamlink

  * Built for simplicity
  * Single binary
  * Continuous Integration


[Streamlink](https://streamlink.github.io/) is a command-line utility which pipes video streams from various services into a video player, such as VLC or mpv. The main purpose of Streamlink is to avoid resource-heavy and unoptimized websites, while still allowing the user to enjoy various streamed content. There is also a Python API available for developers who want access to the stream data.



## Example usage

### Watch a stream

Without docker, streamlink run on a host can be run like this

    streamlink twitch.tv/michimochievee best

This command opens up the stream for live viewing inside VLC or another media player. However, with docker, running streamlink is more involved and there are extra layers of complexity. `insanity54/streamlink` does not include a media player like VLC, so you must instead save the stream to a file in a bind mount, and open the file on the host using a media player.

1. Get a unique output filename

    output_file_basename=stream_$(date +%s%N | cut -b1-13).ts

2. In a terminal, have streamlink record the stream to the output file.

    docker run \
      --mount type=bind,src=./downloads,dst=/home/streamlink/downloads insanity54/streamlink:latest \
      --stdout \
      --record=/home/streamlink/$output_file \
      twitch.tv/michimochievee worst

3. In a second terminal, watch the output file using cvlc (or other media player)

    cvlc --play-and-exit "${output_file}"

    


### Record 10 seconds of stream audio to a file

This can be useful for running audio analysis of a stream.

    docker run --mount type=bind,src=./downloads,dst=/home/streamlink/downloads insanity54/streamlink:latest --stdout --record=/home/streamlink/downloads/stream_$(date +%s%N | cut -b1-13).ts --stream-segmented-duration 00:00:10 twitch.tv/michimochievee audio_only



## Contributing

I want to make this docker image as best as it can be. If you have any feedback or suggestions, create a new topic in the discussions. Feel free to create issues for bug reports.

## Sponsorships

