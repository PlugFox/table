.PHONY: help

# Описание скрипта по `make` или `make help`
help:
	@echo "Make something good"
	@echo " or something worse"
	@echo "  or something else"
	@echo "   with this script"
	@echo ""
	@flutter --version

-include tool/makefile/*.mk