# Youtube to MP3
This script is used to download a youtube video and convert it to mp3. It can also split the audio into several parts (for example it can be used to download whole album or song compilation and split it based on paramteres. See examples.)

## Dependencies
This script uses external [youtube-dl](https://github.com/ytdl-org/youtube-dl), a command line utility to download videos from youtube; and [ffmpeg](https://ffmpeg.org/), a command line utility for manipulation with audio/video files.

## Usage
```
Usage: youtube-to-mp3.sh [OPTIONS] url

  url is YouTube (https://youtube.com) link to the video, such as https://www.youtube.com/watch?v=xFrGuyw1V8s
Options:
  -h     | --help          Shows this help
  -o val | --output val    Name of the output file (extension is optional. Defaults to video title.
  -c val | --config val    Use config file for splitting the audio into several files (can be '-' for stdin)
  -f val | --format val    Output file format, see below

Config file format:
  time name
  ...

  Where
    'time' is mm:ss or hh:mm:ss of when the section starts (it ends with the start of next section or end of file)
    'name' is the name of the output file for this section (extension is optional and doesn't have to be enquoted or escaped)

Output format is one of the following:
    best, aac, flac, mp3, m4a, opus, vorbis, wav
    Defaults to 'best' which guesses best format according to the video (usually mp3 or m4a)
```

## Examples

```
# Just downloads the audio in the best quality and saves to video title
$ ./youtube-to-mp3.sh https://www.youtube.com/watch?v=DPL_SV3n7IU
```

```
# Downloads the audio and converts it to mp3
$ ./youtube-to-mp3.sh -f mp3 https://www.youtube.com/watch?v=DPL_SV3n7IU
```

```
# Downloads the audio and saves it as song.ext, where ext is based on the available audio quality
$ ./youtube-to-mp3.sh -o song https://www.youtube.com/watch?v=DPL_SV3n7IU
```

```
# Downloads the album and saves it in appropriate songs splitted by the time (this is usually found in comments or video description)
$ ./youtube-to-mp3.sh -c - https://www.youtube.com/watch?v=DPL_SV3n7IU
0:00 Blackened
6:41 And Justice for All
16:30 Eye of the Beholder
22:53 One
30:19 The Shortest Straw
36:54 Harvester of Sorrow
42:39 The Frayed Ends of Sanity
50:24 To Live is to Die
1:00:10 Dyers Eve
```
