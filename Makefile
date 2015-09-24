.SILENT:
.PHONY: help

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_NAME       = supervisor
PACKAGE_VERSION    = 3.1.3
PACKAGE_RELEASE    = elao1
PACKAGE_GROUP      = admin
PACKAGE_MAINTAINER = Elao <infra@elao.com>

## Package - Source
PACKAGE_SOURCE = https://pypi.python.org/packages/source/s/supervisor

## Help
help:
	printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	printf " make [target]\n\n"
	printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	awk '/^[a-zA-Z\-\_0-9\.@]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf " ${COLOR_INFO}%-16s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Build
build: build-packages

build-packages:
	docker run \
	    --rm \
	    --volume `pwd`:/srv \
	    --workdir /srv \
	    --tty \
	    debian:wheezy \
	    sh -c '\
	        apt-get update && \
	        apt-get install -y make && \
	        make build-package@debian-wheezy \
	    '

build-package@debian-wheezy:
	apt-get install -y wget python-pip debhelper python-all
	pip install stdeb
	# Get sources
	wget --no-check-certificate ${PACKAGE_SOURCE}/supervisor-${PACKAGE_VERSION}.tar.gz -O ~/package.tar.gz
	# Package description
	echo "[DEFAULT]" > ~/stdeb.cfg
	echo "Package: ${PACKAGE_NAME}" >> ~/stdeb.cfg
	echo "Debian-Version: ${PACKAGE_RELEASE}" >> ~/stdeb.cfg
	echo "Maintainer: ${PACKAGE_MAINTAINER}" >> ~/stdeb.cfg
	echo "Section: ${PACKAGE_GROUP}" >> ~/stdeb.cfg
	# Build
	cd ~ && py2dsc-deb --extra-cfg-file stdeb.cfg package.tar.gz
	# Move package files
	mv ~/deb_dist/*.deb /srv/files
