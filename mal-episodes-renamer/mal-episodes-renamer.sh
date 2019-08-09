#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 url files..."
    echo
    echo "Url is MAL (https://myanimelist.net) link to the anime, such as https://myanimelist.net/anime/1/Cowboy_Bebop"
    echo "Files are list of files (has to be same as number of episodes) in given order, to be renamed."
    echo "This script strips certain characters from the names, such as: ? ! . , '"
    exit 1
fi

mal_url=`echo $1 | sed 's#/$##'`
shift

titles=`curl $mal_url/episode 2>/dev/null |
grep 'class="fl-l fw-b "' |
sed -E 's#.*>(.*)</a>$#\1#' |
sed '
    s/&nbsp;/ /g;
    s/&amp;/\&/g;
    s/&lt;/\</g;
    s/&gt;/\>/g;
    s/&quot;/\"/g;
    s/&#039;/'"'"'/g;
    s/&ldquo;/\"/g;
    s/&rdquo;/\"/g
' | 
tr ' ' '_' | 
tr -d "?/!.,'"
`

ep_count=`wc -l <<< "$titles"`
if [ $ep_count -ne $# ]; then
    >&2 echo "Invalid number of parameters, expected $ep_count"
    exit 1
fi

length=`echo -n $ep_count | wc -m`

count=1
while read -r ep_name; do
    base_name=`basename "$1"`
    dir_name=`dirname "$1"`
    extension=${base_name##*.}

    prefix=`printf "%0$length""d\n" $count`
    mv "$1" "$dir_name"/$prefix"_$ep_name.$extension"

    shift
    ((++count))
done <<< "$titles"
