# ------------------------------------------------------------
# Dotfiles Makefile
# ------------------------------------------------------------
# Usage:
#   make, make stow     -> Symlink all dotfile packages
#   make restow         -> Recreate all symlinks
#   make unstow         -> Remove all symlinks
#   make clean          -> Delete broken symlinks
#   make help           -> Show this help message
# ------------------------------------------------------------

# List of directories (dotfile packages)
PACKAGES := $(shell find . -mindepth 1 -maxdepth 1 -type d -not -name ".git" -exec basename {} \;)

.PHONY: all stow restow unstow clean help

all: stow

## Stow all dotfile packages
stow:
	stow -Rv $(PACKAGES)

## Restow all packages (recreate symlinks)
restow:
	stow -Rv $(PACKAGES)

## Unstow all packages (remove symlinks)
unstow:
	stow -Dv $(PACKAGES)

## Clean up broken symlinks in the home directory
clean:
	find $$HOME -type l ! -exec test -e {} \; -print -delete

## Show help message
help:
	@echo ""
	@echo "Dotfiles Makefile commands:"
	@echo "  make, make stow     - Symlink all dotfile packages into place"
	@echo "  make restow         - Recreate all symlinks (after edits)"
	@echo "  make unstow         - Remove all symlinks"
	@echo "  make clean          - Delete broken symlinks from \$\$HOME"
	@echo "  make help           - Show this help message"
	@echo ""
