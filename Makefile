run: build
	npm start

build:
	mkdir -p _build
	cp -R src/css _build
	cp -R src/js _build
	cp -R src/html _build
	npm run elm
	cp main.js _build

install:
	mkdir -p _build
	npm install

clean:
	rm -rf _build
	rm -rf elm-stuff
	rm -rf node_modules
