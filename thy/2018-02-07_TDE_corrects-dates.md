I've got some photos from a camera with a wrong date setting.

# Corrects file timestamp

After empirically finding a correct enough time shift

```
ls *.JPG | awk '{f=$1; "date -r " f | getline; "date -d \"" $0 " + 8 years + 18 days - 30 minutes\"" | getline; print "touch -d \"" $0 "\"", f}' | dash
```

# Corrects jpeg header and rename

```
jhead -dsft *.JPG
jhead -n%Y-%m-%d_%H-%M-%S *.JPG
```
