FONT = ~/mbf/uw-ttyp0-11x22b.mbf

timings = $(wildcard *.t)
gifs = $(timings:.t=.gif)

all: $(gifs)

%.gif: %.t %.d
	congif -f $(FONT) -w43 -h12 -m1 -l0 -o $@ $^

clean:
	rm *.gif
