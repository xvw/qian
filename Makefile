.PHONY: run build install clean prepeare_release releases %_tarball

run: build
	npm start

build: build_temp_dir
	npm run elm

install: build_temp_dir
	npm install

clean:
	rm -rf _build
	rm -rf _releases
	rm -rf elm-stuff
	rm -rf node_modules

prepare_release: install build

build_%: prepare_release
	npm run $(@)

build_temp_dir:
	mkdir -p _build
	mkdir -p _releases

%.tar: _build/%
	tar zcvf _releases/$(@) $(<)

tarball_%: qian-%-x64.tar
	@echo "$(<) : done"
