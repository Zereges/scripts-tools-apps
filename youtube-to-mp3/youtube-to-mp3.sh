#!/bin/bash

function print_help {
    echo "Usage: $0 [OPTIONS] url"
    echo
    echo "url is YouTube (https://youtube.com) link to the video, such as https://www.youtube.com/watch?v=xFrGuyw1V8s"
    echo "Options:"
    echo "  -h     | --help          Shows this help"
    echo "  -o val | --output val    Name of the output file (extension is optional). Defaults to video title."
    echo "  -c val | --config val    Use config file for splitting the audio into several files (can be '-' for stdio)"
    echo "  -f val | --format val    Output file format, see below"
    echo
    echo "Config file format:"
    echo "  time name"
    echo "  ..."
    echo
    echo "  Where"
    echo "    'time' is mm:ss or hh:mm:ss of when the section starts (it ends with the start of next section or end of file)"
    echo "    'name' is the name of the output file for this section (extension is optional and doesn't have to be enquoted or escaped)"
    echo
    echo "Output format is one of the following:"
    echo "    best, aac, flac, mp3, m4a, opus, vorbis, wav"
    echo "    Defaults to 'best' which guesses best format according to the video (usually mp3 or m4a)"
    echo 
    echo "This script is part of Script-Tools-Apps collection <https://github.com/Zereges/scripts-tools-apps>"
}

rest_args=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
        help_requested=true
        shift
        ;;
        -o|--output)
        output_template="$2"
        output_file="$2"
        shift
        shift
        ;;
        -c|--config)
        if [ "$2" == "-" ]; then
            config_file="/proc/self/fd/0"
        else
            config_file="$2"
        fi
        shift
        shift
        ;;
        -f|--format)
        audio_format="--audio-format $2"
        shift
        shift
        ;;
        *)    # unknown option
        rest_args+=("$1")
        shift
        ;;
    esac
done
set -- "${rest_args[@]}" # restore positional parameters

if [ "$help_requested" = false ]; then
    print_help
    exit 0
fi

if [ $# -ne 1 ]; then
    print_help
    exit 1
fi

url=$1

if [ -z "$output_template" ]; then
    if [ -n "$config_file" ]; then
        remove_tmp=true
    fi
    output_template="%(title)s"
fi;

if [[ ! "$output_template" =~ \.. ]]; then
    output_template+=".%(ext)s"
fi;

if [ -n "$config_file" ]; then
{
    read time_start name
    while read time_end next_name; do
        conf+="$time_start $time_end $name
        "
        time_start="$time_end"
        name="$next_name"
    done;
    conf+="$time_start -1 $name"
} < $config_file
fi
echo "Downloading YouTube file"
output_file=`youtube-dl.exe -x --prefer-ffmpeg $audio_format -o "$output_template" "$1" | grep "Destination" | tail -1 | sed -E 's/[^:]+: (.*)/\1/'`

extension=${output_file##*.}

if [ -n "$config_file" ]; then
    while read start end name; do
        echo "Processing $name.$extension"
        ffmpeg -i "$output_file" -ss $start -to $end -c copy "$name.$extension" 2>/dev/null
    done <<< "$conf"
fi

if [ "$remove_tmp" = true ]; then
    rm -f "$output_file"
fi
