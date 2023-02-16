.ONESHELL:

SHELL=/bin/bash
PYTHON=/usr/bin/python3


define HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("	%-18s %s" % (target, help))
endef
export HELP_PYSCRIPT


help:
	@echo Commands:
	@$(PYTHON) -c "$$HELP_PYSCRIPT" < $(MAKEFILE_LIST)


ngrok:  ## Install/Uninstall ngrok server. action=install|uninstall
ifeq ("$(action)", "install")
	@sudo apt update && \
	  sudo apt install ngrok

else ifeq ("$(action)", "uninstall")
	@sudo apt purge ngrok

else
	@echo "==== Action not found"
endif

ngrok-tunnel:  ## Start ngrok tunnel
	@ngrok start --all --config servers-config.yml


%:
	@:
