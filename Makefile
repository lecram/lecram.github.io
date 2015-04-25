sources := $(shell find . -name '*.nme')
pages = $(sources:.nme=.html)

all: $(pages)

%.html: %.nme gen.sh template.html
	sh gen.sh $< $@

clean:
	rm -f $(pages)
