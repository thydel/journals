checks := src srcs journal journal_jq journal_j2 journal_yml header_md_jq
txt    := this is makefile is meant to be included
. := $(foreach _, $(checks), $(or $($_), $(error $(txt))))))

.DELETE_ON_ERROR:

self    := $(lastword $(MAKEFILE_LIST))
$(self) := $(basename $(self))

metadatas.grep := .*/20[1-2][0-9]-[0-1][0-9]-[0-3][0-9]_[A-Z][A-Z][A-Z]_[^_][^_]*.yml$$
metadatas.tree != find -L $(srcs) -type f -regextype grep -regex '$(metadatas.grep)'
metadatas.json := $(foreach _, $(metadatas.tree), $(tmp)/$(basename $(notdir $_)).json)

ifdef DEBUG
$(warning $(metadatas.tree))
endif

yaml2json.py := import sys, yaml, json;
yaml2json.py += json.dump(yaml.load(sys.stdin), sys.stdout, indent=4, default=str, sort_keys=True)
yaml2json    := python -c '$(yaml2json.py)'

metadata = < $< $(yaml2json) | jq '.[] += { base: "$(dir $<)" }' > $@

$(strip $(foreach _, $(metadatas.tree), $(eval $(tmp)/$(basename $(notdir $_)).json: $_; $$(call metadata))))

$(metadatas.tree):;
$(tmp)/metadatas.json: $(metadatas.json); jq -s add $^ > $@

$(tmp)/$(journal).json: $(journal_jq) $(tmp)/metadatas.json jqlib/index.jq; $(wordlist 1, 2, $^) > $@

# files

getfiles.jq  = .[] | select(.$1) | .base as $$base | .$1[] | $$base + .

files_id    := markdowns rests files
files_mk    := $(files_id:%=$(tmp)/%.mk)
files_mk.cmd =  jq '$(call getfiles.jq,$*)' $< | xargs echo '$*.tree := ' > $@
$(files_mk): $(tmp)/%.mk : $(tmp)/metadatas.json; $(files_mk.cmd)

$(self): $(files_mk)
include $(files_mk)

files_tree := $(foreach _, $(files_id), $($_.tree))
files := $(files_tree:%=$(dest)/%)

dir-tree := $(sort $(foreach _, $(files), $(dir $_).stone))
$(dir-tree):; mkdir -p $(@D); touch $@

cp-default = cp $< $@
$(filter-out %.md, $(files)): $(dest)/% : % $(dir-tree); $(cp-default)

pandoc-toc := pandoc --template=toc-template.txt --toc -t markdown_github
gh-md-toc  := tmp/gh-md-toc
mk-toc     := $(pandoc-toc)

cp-markdown  = $(header_md_jq) -r
cp-markdown +=   --arg id $(basename $(notdir $@)) --arg base /$(dest)/$(journal).md
cp-markdown +=   $(tmp)/$(journal).json > $@;
cp-markdown += $(mk-toc) $< >> $@;
cp-markdown += echo -e '\n' >> $@;
cp-markdown += cat $< >> $@
$(filter %.md, $(files)): $(dest)/%.md : %.md %.yml $(dir-tree); $(cp-markdown)

toplevel ?= https://github.com/Epiconcept-Paris/infra-journals-indexed

$(tmp)/$(journal).md  = $< -e TMP=$(tmp) -e SRC=$(src) -e TOPLEVEL=$(toplevel) -e TEMPLATE=$(journal_j2) -D &&
$(tmp)/$(journal).md += touch $@ -r $$(ls -t $^ | head -1)
$(tmp)/$(journal).md: $(journal_yml) $(journal_j2) $(tmp)/$(journal).json; $($@)

ifdef PANDOC
$(tmp)/$(journal).toc: $(tmp)/$(journal).md; $(mk-toc) $< > $@
else
fix-toc = sed -re 's/^(.*)<a[^<]+>(.*)<\/a>(.*)$$/\1\2\3/'
$(tmp)/$(journal).toc: $(gh-md-toc) $(tmp)/$(journal).md; $^ | $(fix-toc) > $@
endif

$(dest)/$(journal).md: $(tmp)/$(journal).md $(tmp)/$(journal).toc; cat $^ > $@

main: $(dest)/$(journal).md $(files)

$(gh-md-toc) := https://raw.githubusercontent.com/ekalinin/github-markdown-toc/master/gh-md-toc
$(gh-md-toc):; (cd $(@D); wget $($@)); chmod a+x $@

clean:; rm -r tmp
retoc:; rm $(tmp)/$(journal).toc
.PHONY: clean
