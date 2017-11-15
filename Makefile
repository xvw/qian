.PHONY: clear

all: run

build:
	webpack

run: build
	electron main.js


install:
	npm install

clean:
	rm -rf node_modules
	rm -rf elm-stuff
