# find all markdown files
MARKDOWN=$(shell find . -iname "*.md")

# form all html counterparts
HTML=$(MARKDOWN:.md=.html)

.PHONY = all tar clean

# set things up
all: $(HTML)

%.html: %.md
	wget "https://raw.githubusercontent.com/oxalorg/sakura/master/sakura.css"
	pandoc -css ~/Projects/website/sakura.css --from markdown --to html $< -o $@

tar: $(MARKDOWN)
	tar --exclude=jemdoc_version/ --exclude=eqs/ --exclude=.git/ --exclude=non_yet_published.txt --exclude=README.md -czvf website.tar.gz ./

clean:
	rm $(HTML)