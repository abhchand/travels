#!/usr/bin/env bash 

FILE=$1

FILE_NAME="${FILE%.*}"
FILE_EXT="${FILE##*.}"

FILE_CROPPED="$FILE_NAME-cropped.$FILE_EXT"
FILE_THUMB="$FILE_NAME-thumb.$FILE_EXT"

# Strip EXIF Data
# See https://photo.stackexchange.com/a/119646
exiftool -all:all= -overwrite_original -tagsfromfile @ -exif:Orientation $FILE

# Crop to 3:4 aspect ratio (vertical)
# 
#   to crop from the top, use -gravity north
#   to crop with an offset, append an offset like `3:4+0+150`, for 150px lower (y)
convert $FILE -gravity center -auto-orient -crop 3:4 $FILE_CROPPED

# Create thumbnail of file
convert $FILE_CROPPED -auto-orient -thumbnail 350x350 -unsharp 0x.5 $FILE_THUMB

# Cleanup - promote cropped file over original file
mv $FILE $FILE.old
mv $FILE_CROPPED $FILE

echo "Cropped $FILE (Backed up to $FILE.old)"
echo "Created thumb $FILE_THUMB"
