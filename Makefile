install:
	cd ctags; ./configure
	cd ctags; make
	cp ./.vimrc ~/.vimrc
	cp -r ./.vim ~
	mkdir ~/.vim/ctags
	cd ctags; cp -r . ~/.vim/ctags
