def by_key(key): map({(key): .}) | add;

# input:  [{"id":"x","tags":["a","b","c"]},{"id":"y","tags":["c","d","e"]},{"id":"z"}]
# call: lv2k(.id; .tags)
# output: {"a":["x"],"b":["x"],"c":["x","y"],"d":["y"],"e":["y"]}
def lv2k(i; l): reduce map(i as $_ | l[]? | {k: ., v: [$_]})[] as $_ ({}; .[$_.k] += $_.v);

def sort_lists: if type == "array" then sort else . end;
