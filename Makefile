define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

PORT ?= 47967

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

.venv/bin/python:
	conda env create -p ./.venv -f binder/environment.yml

venv: ./.venv/bin/python  ## create the local virtual environment

install: .venv/bin/python ## install Jupyter kernel into user environment
	$< -m ipykernel install --user --name binder-kernel-test --display-name "Binder Kernel Test"

uninstall: ## remove Jupyter kernel from user environment
	jupyter kernelspec remove -f binder-kernel-test || true

dist-clean: uninstall ## remove env files
	rm -rf .venv

jupyter-notebook: install  ## run a notebook server (system-jupyter)
	jupyter notebook --debug --no-browser --port=$(PORT)

jupyter-lab: install  ## run a jupyterlab server (system-jupyter)
	jupyter lab --debug --no-browser --port=$(PORT)
