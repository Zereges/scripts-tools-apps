# ID3 Tags Generator
This script is used to generate [ID3](https://en.wikipedia.org/wiki/ID3) meta information for MP3 files (such as title, track number, author, album and year). It supports unicode character in names of files.

## Dependencies
This script uses external [id3-tags-cli](https://github.com/Zereges/id3-tag-cli), a command line utility to modify ID3 tags.

## Usage
```
Usage: ./id3-tags-generator.sh folder

folder is supposed to have following structure
ARTIST
   ALBUM1
      SONG11
      SONG12
      SONG13
   ALBUM2
      SONG21
      SONG22
   ALBUM3
      SONG31
      SONG32
      SONG33
      SONG34

ARTIST is just name of the artist/band.
ALBUM has the following format: 'YEAR NAME', where YEAR is release year and NAME is the name of the album.
SONG has the following format: 'TRACK NAME.mp3', where TRACK is track number and NAME is the name of the song.

Each song will contain the information about artist, album, year, track number and the name.
```
