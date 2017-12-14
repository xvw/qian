.PHONY: clear

all: run

build:
	node ./node_modules/electron/install.js
	./node_modules/.bin/webpack

run: build
	./node_modules/.bin/electron main.js


install:
	npm install

app: install build
	rm -rf qian-darwin-x64.zip
	./node_modules/.bin/electron-packager . qian --overwrite --icon=icon.icns
	zip -r qian-darwin-x64.zip qian-darwin-x64

clean:
	rm -rf qian-darwin-x64.zip
	rm -rf node_modules
	rm -rf elm-stuff
