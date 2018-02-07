#!/usr/bin/make -f

top:; @date
.PHONY: top

self    := $(lastword $(MAKEFILE_LIST))
$(self) := $(basename $(self))
$(self):;

MAKEFLAGS += -Rr
SHELL := $(shell which bash)

.DEFAULT_GOAL := main
.DELETE_ON_ERROR:

src := tde
tde := pro thy

tmp ?= tmp/$(src)
srcs = $($(src))
dest := indexed/$(src)
. != mkdir -p $(tmp) $(dest)

toplevel    := https://github.com/thydel/journals-indexed

journal     := journal-$(src)
journal_jq  := journal-v2.jq
journal_j2  := journal-v2.j2
journal_yml := journal-v2.yml
header_md_jq := header-md-v2.jq

include journal-v2.mk
