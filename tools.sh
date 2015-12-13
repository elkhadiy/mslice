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

. ./bash_colors

function dbg {
    caller=$(basename "$0")
    caller="${caller%.*}"
    [[ $1 = "ok" ]] && status=$Green || status=$Red
    shift
    echo -e $Yellow"["$caller"]"$status"[DBG]"$Color_Off "$@" >&2
}

function cout {
    caller=$(basename "$0")
    caller="${caller%.*}"
    echo -e $Yellow"["$caller"]"$Color_Off "$@"
}
