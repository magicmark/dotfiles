.PHONY: all
all: bootstrap linkfiles

venv: Makefile requirements-dev.txt
	rm -rf venv
	virtualenv venv --python=python3
	venv/bin/pip install -r requirements-dev.txt
	venv/bin/pre-commit install -f --install-hooks

.PHONY: bootstrap
bootstrap:
	bin/./bootstrap.sh

.PHONY: linkfiles
linkfiles: venv
	python bin/linkfiles.py

.PHONY: test
test:
	docker build -t markl/dotfiles_test:v0.2 .
	docker run -t -i markl/dotfiles_test:v0.2

clean:
	rm -rf venv
