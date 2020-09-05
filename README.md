# binder-kernel-test

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/goerz-testing/binder-kernel-test/master)

Test a binder repo with a custom project kernel

This repo illustrates how to set up a project that runs both locally and on Binder with a "Project Kernel"

Using "Project Kernels" means that the Jupyter Server does not have to be installed in the project virtual environment (venv). I recommend this approach because Jupyter does not isolate well: it likes to read extensions, kernels and various other kinds of settings from the users `~/.jupyter` directory. Thus, the idea is to have the `jupyter` executable installed in the user's "main" environment (not the project environment), and install a "project kernel" into `~/.jupyter`.
