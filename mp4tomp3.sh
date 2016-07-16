#!/bin/sh                                                                                                                                                     

vcodec="mp4v"
acodec="mp3"
bitrate="1024"
arate="128"
outputFileExtension="mp3"

# For Linux                                                                                                                                                   
#vlc="/usr/bin/vlc"                                                                                                                                           
# For OSX                                                                                                                                                     
vlc="/Applications/VLC.app/Contents/MacOS/VLC"

if [ ! -e "$vlc" ]; then
    echo "Command '$vlc' does not exist"
    exit 1
fi

for file in "$@"; do
    echo "=> Transcoding '$file'... "

    dst=`dirname "$file"`
    new=`basename "$file" | sed 's@\.[a-z][a-z][a-z]$@@'`.$outputFileExtension

    $vlc -I dummy -q "$file" \
       --sout "#transcode{acodec=\"$acodec\",ab=128,channels=2,samplerate=44100}:std{access=file,mux=raw,dst=\"$dst/$new\",access=file}" \
       vlc://quit
    ls -lh "$file" "$dst/$new"
    echo
done
