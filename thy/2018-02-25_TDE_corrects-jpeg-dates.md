I've got some photos from a camera with a wrong date setting again
(not my camera this time).

# Optimistically rename files from EXIF header

```
jhead -n%Y-%m-%d_%H-%M-%S -ft *.JPG
```

Only to find the camera time is back in time

# Empirically find a correct enough time shift

Let's fix the first shot at Mon Feb 19, around 10 AM

Incremental time base search

```console
$ date -r 2013-12-09_19-03-18.jpg | xargs -i date -d "{} + 5 years"
Sun Dec  9 19:03:18 CET 2018
$ date -r 2013-12-09_19-03-18.jpg | xargs -i date -d "{} + 5 years - 10 months"
Fri Feb  9 19:03:18 CET 2018
$ date -r 2013-12-09_19-03-18.jpg | xargs -i date -d "{} + 5 years - 10 months + 10 days"
Mon Feb 19 19:03:18 CET 2018
$ date -r 2013-12-09_19-03-18.jpg | xargs -i date -d "{} + 5 years - 10 months + 10 days - 9 hours"
Mon Feb 19 10:03:18 CET 2018
```

# Corrects file timestamp

```
ls *.jpg | awk '{ f = $1; c = "date -r " f; c | getline; close(c); c = "date -d \"" $0 " + 5 years - 10 months + 10 days - 9 hours\""; c | getline; close(c); print "touch -d \"" $0 "\"", f}' | dash
```

# Corrects jpeg header, rename and optimize

```
jhead -dsft *.jpg
jhead -n%Y-%m-%d_%H-%M-%S *.jpg
jpegoptim -p -m90 *.jpg
```
