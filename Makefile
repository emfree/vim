install:
	cd ctags; ./configure
	cd ctags; make
	cp ./.vimrc ~/.vimrc
	cp -r ./.vim ~
