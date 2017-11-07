.PHONY: clear

all: run

build: install
	webpack

run: build
	electron main.js


install: 
	npm install

clean:
	rm -rf node_modules
	rm -rf elm-stuff