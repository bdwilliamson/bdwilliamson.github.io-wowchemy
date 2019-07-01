#!/bin/bash

# find all markdown files
MARKDOWN=$(shell find . -iname "*.md")

# form all html counterparts
HTML=$(MARKDOWN:.md=.html)

.PHONY = all tar clean

# pull in css file if necessary
ifeq ("$(wildcard $(/home/brian/Projects/website/sakura.css))", "")
$( wget "https://raw.githubusercontent.com/oxalorg/sakura/master/css/sakura.css" )
endif

# create htmls
all: $(HTML)
	
%.html: %.md
	pandoc -s -c ~/Projects/website/sakura.css --metadata-file=_site.yml --from markdown --to html $< -o $@

# create tarball
tar: $(MARKDOWN)
	tar --exclude=jemdoc_version/ --exclude=eqs/ --exclude=.git/ --exclude=non_yet_published.txt --exclude=README.md --exclude old_markdown_files/ -czvf website.tar.gz ./

# clean it out
clean:
	rm $(HTML)