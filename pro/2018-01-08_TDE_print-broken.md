# First floor printer works no more for me

I don't print that often and didn't notice when my capacity to print
on first floor pinter broke. Possibly a consequence of upgrading from
`jessie` to `stretch`.

# And menu access to printer diag is missing

```
sudo aptitude install print-manager system-config-printer
```

# Then strange behaviour to unlock print setting

- First my password seems not to work
- Then I noticed I was requested the password of another user than myself (`test`)
- And understood that since I used user `test` to test for `%sudo` feature
  this user was the only one in group `sudo` and print setting use it
  as default user to unlock privileged operations
  
# Once unlock, activate debug

And conclude that the error was probably due to missing filter (while
the reporting was "filter failed")

# Easily solved by finding missing packages

```
sudo aptitude install hplip hplip-gui hplip-ppds
```
