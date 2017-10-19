#!/usr/local/bin/jq -Sf

include "jqlib/index";

def extract(k): lv2k(.id; k) | walk(sort_lists);
def select_ids(k): map(select(has(k))) | map(.id) | sort;

. as $in
  | [ "id", "markdowns", "rests", "files", "group" ] as $types
  | [ "dates", "tags", "nodes", "repos", "users", "actors", "requesters", "tickets" ] as $keys
  | by_key(.id) as $all_items
  | $keys as $all_keys
  | reduce $keys[]  as $_ ({}; .["by_"  + $_] = ($in | extract(getpath([$_])))) | . as $by_keys
  | reduce $types[] as $_ ({}; .["has_" + $_] = ($in | select_ids($_))) | . as $has_keys
  | { $all_items, $all_keys } + $by_keys + $has_keys | . as $journal
  | (
     [$journal.has_group[] | $all_items[.] as { $id, $group } | $group[] | { (.): $id }]
       | reduce .[] as $_ ({}; . + $_)
     ) as $groups
  | $groups | reduce keys[] as $_ ($journal; .all_items[$_].groups += [$groups[$_]])
  | . as $journal
  | { $journal }
