# Howto fix orientation for old picture without EXIF orientation

Use `gthumb` to manually select and lossless rotate picture in some *folder* , then

```
exiftool "-FileModifyDate<DateTimeOriginal" $folder
```

`exiftool` tricks [Found on exiftool forum][]

[Found on exiftool forum]:
	http://u88.n24.queensu.ca/exiftool/forum/index.php?topic=4596.0
