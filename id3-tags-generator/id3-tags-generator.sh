#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 folder"
    echo
    echo "folder is supposed to have following structure"
    echo "ARTIST"
    echo "   ALBUM1"
    echo "      SONG11"
    echo "      SONG12"
    echo "      SONG13"
    echo "   ALBUM2"
    echo "      SONG21"
    echo "      SONG22"
    echo "   ALBUM3"
    echo "      SONG31"
    echo "      SONG32"
    echo "      SONG33"
    echo "      SONG34"
    echo
    echo "ARTIST is just name of the artist/band."
    echo "ALBUM has the following format: 'YEAR NAME', where YEAR is release year and NAME is the name of the album."
    echo "SONG has the following format: 'TRACK NAME.mp3', where TRACK is track number and NAME is the name of the song."
    echo "Each song will contain the information about artist, album, year, track number and the name."
    echo
    echo "This script is part of Script-Tools-Apps collection <https://github.com/Zereges/scripts-tools-apps>"
    exit 1
fi

artist_path="$1"
artist_name=`basename "$1"`

for album in "$artist_path"/*; do
    year=`basename "$album" | sed -E 's/([^ ]+) .*/\1/'`
    album_name=`basename "$album" | sed -E 's/[^ ]+ (.*)/\1/'`

    echo Processing $album_name
    for song in "$album"/*.mp3; do
        track=`basename "$song" | sed -E 's/([^ ]+) .*/\1/'`
        title=`basename "$song" | sed -E 's/[^ ]+ (.*)/\1/'`
        title=${title%.*}

        id3-tags-cli -a "$artist_name" -y $year -A "$album_name" -T $track -t "$title" "$song"
    done
done
