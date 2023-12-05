NAME := zathura

zathura: dep src
	@rm -f src/build/zathura
	@cd src && mkdir -p build && meson setup build && cd build && ninja
	@cp src/build/zathura zathura
	@./version.sh $(NAME)
dep:
	@sudo apt build-dep $(NAME)

src:
	@rm -rf src
	@apt source $(NAME)
	@rm -rf $(NAME)_*.tar.xz $(NAME)_*.dsc
	@mv $(NAME)*/ src

	@./patch.sh

clean:
	@rm -rf src

install:
	@./version.sh $(NAME) check
	@diff zathura /usr/local/bin/zathura || sudo cp zathura /usr/local/bin
