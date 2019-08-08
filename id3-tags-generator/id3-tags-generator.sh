#!/bin/bash

artist_path="$1"
artist_name=`basename "$1"`

for album in "$artist_path"/*; do
    year=`basename "$album" | sed -E 's/([^-]+) - .*/\1/'`
    album_name=`basename "$album" | sed -E 's/[^-]+ - (.*)/\1/'`

    echo Processing $album_name
    for song in "$album"/*.mp3; do
        track=`basename "$song" | sed -E 's/([^ ]+) .*/\1/'`
        title=`basename "$song" | sed -E 's/[^ ]+ (.*)/\1/'`
        title=${title%.*}

        id3-tags-cli -a "$artist_name" -y $year -A "$album_name" -T $track -t "$title" "$song"
    done
done
