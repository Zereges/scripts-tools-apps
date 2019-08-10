# MAL Episodes Renamer
This script is used to rename list of video files according to the list of episodes listed on MyAnimeList.net page. The format of new file names is following *`N_Name`* where `N` is zero padded number of the episode and `Name` is the name of the episode with certain special characters removed and with spaces (&nbsp;) turned to underscores (`_`).

## Usage
```
Usage: mal-episodes-renamer.sh url files...

  url is MAL (https://myanimelist.net) link to the anime, such as https://myanimelist.net/anime/1/Cowboy_Bebop
  Files are list of files (has to be same as number of episodes) in given order, to be renamed.
  This script strips certain characters from the names, such as: ? ! . , '
```

## Example

```
$ ls cowboy-bepop/
  ep1.mkv ep2.mkv ep3.mkv ep4.mkv ep5.mkv ep6.mkv
  ...

$ ./mal-episodes-renamer.sh https://myanimelist.net/anime/1/Cowboy_Bebop cowboy-bepop/
$ ls cowboy-bepop/
  01_Asteroid_Blues.mkv    02_Stray_Dog_Strut.mkv           03_Honky_Tonk_Women.mkv
  04_Gateway_Shuffle.mkv   05_Ballad_of_Fallen_Angels.mkv   06_Sympathy_for_the_Devil.mkv
  ...
```