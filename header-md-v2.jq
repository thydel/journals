#!/usr/local/bin/jq -Sf

.journal.all_items[$id] as $item
  | (
     @text "**\($item.title)**\n",
     (@text "- [all index](\($base))"),
     ($item.dates // empty | [.[] | @text "[\(.)](\($base)#dates-\(.))"] | join(", ") | @text "- dates: \(.)"),
     ($item.groups // empty | [.[] | @text "[\(.)](\($base)#group-\(.))" | ascii_downcase ]
	| join(", ") | @text "- groups: \(.)"),
     ($item.tags // empty | [.[] | @text "[\(.)](\($base)#tags-\(.))"] | join(", ") | @text "- tags: \(.)" ),
     ($item.nodes // empty | [.[] | @text "[\(.)](\($base)#nodes-\(.))"] | join(", ") | @text "- nodes: \(.)"),
     ($item.repos // empty | join(", ") | @text "- repos: \(.)"),
     ($item.tickets // empty | join(", ") | @text "- tickets: \(.)"),
     ($item.actors // empty | [.[] | @text "[\(.)](\($base)#actors-\(.))" | ascii_downcase ]
	| join(", ") | @text "- actors: \(.)"),
     @text "\n\n"
     )
