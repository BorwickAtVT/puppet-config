.PHONY: files librarian-puppet all

all: files librarian-puppet

files:
	cd modules/vtconfig/files && make

librarian-puppet:
	librarian-puppet install
