# Makefile for ~/dotfiles/

# pick up files
EXCLUDE_FILES := .git .gitignore
FILES_ := $(wildcard .??*)
FILES := $(filter-out $(EXCLUDE_FILES), $(FILES_))

# OSType dependent 
ifeq ($(findstring Windows, $(OS)), Windows)
OSType := Windows
FILES  += $(wildcard _*)
HOME_DIR := $(strip $(subst /,\, $(shell sh -c 'cd; pwd -W')))
else
OSType := Linux
HOME_DIR := ~
endif	

.PHONY: all info init_Windows init_Linux tameshi

all: init_$(OSType)

info:
	@echo "OS     =" $(OS)
	@echo "OSType =" $(OSType)
	@echo "FILES  =" $(FILES)
	@echo DOTFILES_FILES = $(DOTFILES_FILES)

init_Windows: info
	@echo == $@ ==
	@$(foreach val,$(FILES), cmd /c "mklink $(shell if [ -d $(val) ]; then echo /d; fi) $(HOME_DIR)\$(val) dotfiles\$(val)";)
	@cmd /c "mklink /d $(HOME_DIR)\vimfiles dotfiles\.vim"

init_Linux: info
	@echo == $@ ==
	@$(foreach val,$(FILES), $(shell sh -c 'if [ ! -e ~/$(val) ]; then ln -s $(abspath $(val)) $(HOME_DIR)/$(val); fi'))

