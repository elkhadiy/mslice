# MSLICE

A simple tool to slice mp3s into smaller chunks using ffmpeg

## Usage
```
./mslice $filepath <list_of_timestamps>
```
the `<list_of_timestamps>` is something like 0:00 2:43 7:18 11:28 where
each timestamp is the start of the new slice

## TODO
* Sanity check
* slice renaming
* bulk entry (copypaste from yt description)
* simple gui with zenity?
* ?
