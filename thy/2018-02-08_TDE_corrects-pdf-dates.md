# Set PDF file timestamp from metadata

```
ls *.pdf | awk '{ f=$0; s=" "; q="\""; "exiftool -s3 -CreateDate -d" s q "%Y-%m-%d %H:%M:%S" q s q f q | getline; print "touch -d" s q $0 q s q f q }' | dash
```
