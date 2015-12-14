# Copyright (C) 2015  Yassine El Khadiri
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA

#!/bin/bash

. ./tools.sh

version=0.1

function header {
    cout "mslice version "$version
    cout "https://github.com/elkhadiy/mslice"
}

function getlaststamp {
    echo $(ffprobe "$1" 2>&1 | grep Duration: \
				| awk '{print $2}' | sed -s 's/,//')
}

function slice {
    ffmpeg -i "$1" -ss "$2" -to "$3" -acodec copy "$4" &> /dev/null
}

function mslice {
    filepath="$1"
    file="$(basename "$1")"
    filename="${file%.*}"
    extention="${file##*.}"
    shift
    declare -a timestamps
    for i in $( seq 0 $(( $#-1 ))); do
	timestamps[$i]=$1
	shift
    done
    len=${#timestamps[@]}
    last=$(getlaststamp "$filepath")
    
    dbg ok "I assume all arguments are sane..."
    dbg ok "No need to supply the mp3 duration as last timestamp,"\
	    "I use ffprobe for that ;)"
    dbg ok "File      :" $Blue"$filepath"$Color_Off
    dbg ok "Filename  :" $Blue"$filename"$Color_Off
    dbg ok "Extention :" $Blue"$extention"$Color_Off
    dbg ok "Timestamps given ("$Blue"$len"$Color_Off")" ":" \
			    $Blue"${timestamps[@]}"$Color_Off
    dbg ok "Last timestamp :" $Blue$last$Color_Off

    from="00:00"
    to="${timestamps[0]}"
    newfile="$filename.slice0.$extention"
    dbg ok Creating slice from $Blue"$from"$Color_Off \
	to $Blue"$to"$Color_Off \
	in $Blue"$newfile"$Color_Off
    slice "$filepath" "$from" "$to" "$newfile"

    if [ $len -gt 1 ]; then
	for i in $(seq 1 $(( $len - 2 ))); do
	    from="${timestamps[$i]}"
	    to="${timestamps[$(( $i+1 ))]}"
	    newfile="$filename.slice$i.$extention"
	    dbg ok Creating slice from $Blue$from$Color_Off \
		to $Blue$to$Color_Off \
		in $Blue$newfile$Color_Off
	    slice "$filepath" "$from" "$to" "$newfile"
	    #touch "$newfile"
	done
    fi

    from="${timestamps[$(($len-1))]}"
    to="$last"
    newfile="$filename.slice$(($len)).$extention"
    dbg ok Creating slice from $Blue"$from"$Color_Off \
	to $Blue"$to"$Color_Off \
	in $Blue"$newfile"$Color_Off
    slice "$filepath" "$from" "$to" "$newfile"
    #touch "$newfile"

}

header
mslice "$@"
