# Kamaleo Tunnel Makefile
# Priority: CLI args > .env file > defaults

# Load .env file if it exists (must come before defaults)
ifneq (,$(wildcard ./.env))
	include .env
	export
endif

# Default values (only used if not set via CLI or .env)
KAMALEO_APP_PORT    ?= 3000
KAMALEO_USER   ?= kamhole
KAMALEO_HOST   ?= tunnel.krakenrb.dev
KAMALEO_SSH_PORT ?= 2222
KAMALEO_PORT   ?= 8080

# SSH tunnel command
SSH_TUNNEL_CMD = ssh -N -T \
	-R 0.0.0.0:$(KAMALEO_PORT):localhost:$(KAMALEO_APP_PORT) \
	$(KAMALEO_USER)@$(KAMALEO_HOST) \
	-p $(KAMALEO_SSH_PORT)

.PHONY: run config help

run:
	@echo "🚀 Starting Kamaleo Tunnel..."
	@echo "   $(KAMALEO_HOST):$(KAMALEO_PORT) → localhost:$(KAMALEO_APP_PORT)"
	@echo "   URL: https://$(KAMALEO_HOST)"
	@echo ""
	@$(SSH_TUNNEL_CMD)

config:
	@echo "Current configuration:"
	@echo "  KAMALEO_APP_PORT:     $(KAMALEO_APP_PORT)"
	@echo "  KAMALEO_USER:    $(KAMALEO_USER)"
	@echo "  KAMALEO_HOST:    $(KAMALEO_HOST)"
	@echo "  KAMALEO_SSH_PORT: $(KAMALEO_SSH_PORT)"
	@echo "  KAMALEO_PORT:    $(KAMALEO_PORT)"

help:
	@echo "Usage: make [target] [VAR=value]"
	@echo ""
	@echo "Targets:"
	@echo "  run     Start the SSH tunnel (default)"
	@echo "  config  Show current configuration"
	@echo "  help    Show this help message"
	@echo ""
	@echo "Variables can be set via:"
	@echo "  1. Command line:  make run KAMALEO_APP_PORT=3001"
	@echo "  2. .env file:     KAMALEO_APP_PORT=3001"
	@echo "  3. Defaults in Makefile"

.DEFAULT_GOAL := run