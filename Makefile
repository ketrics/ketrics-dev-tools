#Runtime vars
VIRTUAL_ENV = venv
FUNCTION_HANDLER = lambda_handler


#Default commands
install: virtual
build: build_package


virtual:
	@echo "--> Setup and activate virtualenv"
	if test ! -d "$(VIRTUAL_ENV)"; then \
	     rm -rf venv; \
		pip install virtualenv; \
		virtualenv -p python3 $(VIRTUAL_ENV); \
		source ./venv/bin/activate; \
		pip install -r ./requirements.txt; \
	fi
	@echo ""


build_package:
	# Clean folders
	rm -rf dist build

	# Build
	python3 setup.py sdist bdist_wheel


push-test:
	python3 -m twine upload --repository-url https://test.pypi.org/legacy/ dist/*

push:
	python3 -m twine upload dist/*