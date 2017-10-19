#!/usr/bin/make -f

top:; @date
.PHONY: top

self    := $(lastword $(MAKEFILE_LIST))
$(self) := $(basename $(notdir $(self)))
$(self):;

MAKEFLAGS += -Rr
SHELL != which bash

.ONESHELL:
.DELETE_ON_ERROR:

_ :=
_ +=

ifeq ($($(self)),mds-to-ymls)
suf := md
txt := markdowns
else ifeq ($($(self)),rsts-to-ymls)
suf := rst
txt := rests
else
$(error no way to tell suffix)
endif

grep   := .*/20[1-2][0-9]-[0-1][0-9]-[0-3][0-9]_[A-Z][A-Z][A-Z]_[^_][^_]*.$(suf)$$
txts   != find -type f -regextype grep -regex '$(grep)' -printf '%f\n'

ids    := $(txts:.$(suf)=)
ymls   := $(ids:=.yml)

fields := date user label

define extract
$(foreach n, $(shell seq $(words $(fields))),
  $(eval $(word $n, $(fields)) := $n))
$(foreach i, $(ids),
  $(eval $i.splitted := $(subst _,$_,$i))
  $(foreach f, $(fields),
    $(eval $i.$f := $(word $($f), $($i.splitted)))))
endef
$(strip $(extract))

define yml
if ! test -f $@;
then
  echo '- id: $*' > $@;
  cat <<! | sed -e 's/^/  /' >> $@;
actors: [ $($*.user) ]
dates: [ $($*.date) ]
$(txt): [ $< ]
nodes: []
repos: []
tickets: []
tags: []
title: "$(subst -,$_,$($*.label))"
!
fi
endef

$(ymls): %.yml : %.$(suf); @$(yml)

main: $(ymls);
.PHONY: main
