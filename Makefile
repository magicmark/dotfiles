all: test

venv: Makefile requirements-dev.txt
	rm -rf venv
	virtualenv venv --python=python3
	venv/bin/pip install -r requirements-dev.txt
	venv/bin/pre-commit install -f --install-hooks

bootstrap:
	bin/./bootstrap.sh

linkfiles: venv
	python bin/linkfiles.py

test:
	docker build -t markl/dotfiles_test:v0.1a .
	docker run -t -i markl/dotfiles_test:v0.1a

clean:
	rm -rf venv
