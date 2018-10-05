run:
	npm start

build:
	npm run elm

install:
	mkdir -p _build
	npm install

clean:
	rm -rf _build
	rm -rf elm-stuff
	rm -rf node_modules
