#generation command ./generate_pngs.sh ../beamng-steam-background.mp4

#!/bin/bash
set -x

if [ -z $1 ]; then
    exit -1
else
    base="$(basename -- $1)"
    name="${base%.*}"
fi

if [ -z $2 ]; then
    dir=$name
else
    dir=$2
fi

mkdir -p $dir

# Extract frames from video
ffmpeg -i "$1" -vf "fps=10" "$dir/${name}_%03d.png"
