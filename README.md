# Travels

Source for https://abhchand.me/travels

# Adding a new photo

Strip EXIF data:

```bash
exiftool -all= -overwrite_original file.jpeg
```

Crop to 3:4 aspect ratio (vertical)

```bash
magick convert file.jpeg -gravity center -crop 3:4 file-out.jpeg

# to crop from the top, use -gravity north
# to crop with an offset, append an offset like `3:4+0+150`, for 150px lower (y)
```

Create thumbnail of file

```bash
convert file.jpg -auto-orient -thumbnail 350x350 -unsharp 0x.5 file-thumb.jpg
```
