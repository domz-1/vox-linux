.PHONY: all install uninstall test

all:
	@echo "Run 'make install' to install Vox Linux"

install:
	@bash ./install.sh

uninstall:
	@bash ./uninstall.sh

test:
	@./bin/vox "Testing Vox Linux Text to Speech"
