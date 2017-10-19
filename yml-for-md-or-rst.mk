#!/usr/bin/make -f

top:; @date
.PHONY: top

self    := $(lastword $(MAKEFILE_LIST))
$(self) := $(basename $(notdir $(self)))
$(self):;

SHELL != which bash
.ONESHELL:

ifeq ($($(self)),yml-for-md)
txt := markdowns
suf := md
else ifeq ($($(self)),yml-for-rst)
txt := rests
suf := rst
else
$(error no way to tell txt)
endif

thy    := TDE
evens  := ESC
cedric := CGD

date  != date +%F
label := $(MAKECMDGOALS)
title := $(subst -, ,$(label))
actor := $($(USER))
id    := $(date)_$(actor)_$(label)
files := $(id).$(suf) $(id).yml

$(suf) = echo '\# $(id)' >  $@

define yml
echo '- id: $(id)' > $@
cat <<! | sed -e 's/^/  /' >> $@
actors: [ $(actor) ]
dates: [ $(date) ]
$(txt): [ $(id).$(suf) ]
files: []
nodes: []
repos: []
tickets: []
tags: []
title: "$(title)"
!
endef

$(label): $(files)
$(files): $(id).% :; $($*)

.DEFAULT: $(files);
