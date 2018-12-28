# MSLICE

A simple tool to slice mp3s into smaller chunks using ffmpeg

## Usage
```
./mslice $filepath <list_of_timestamps>
```
the `<list_of_timestamps>` is something like `2:43 7:18 11:28` where
each timestamp is the start of a new slice.
The first slice `0:00 2:43` and last `11:28 14:12` for example are made
automagically.

### Example usage
Given a youtube video id (the `?v=...` variable in the address bar) fetch and slice it using the timestamps in the video description
```bash
~$ video=youtube_video_id filename="$(youtube-dl -x $video --get-filename)" youtube-dl -x $video --audio-format opus && ./mslice.sh "${filename%.*}".opus $(for i in $(echo $(youtube-dl --get-description $video) | grep -Po '\d+:\d+'); do echo $i; done)
```

## TODO
* Sanity check (working dir, file existing...)
* slice renaming
* ~~bulk entry (copypaste from yt description)~~
* simple gui with zenity?
* ?
