.PHONY: html-files
html-files:
	docker run \
		--volume "${shell pwd}:/data" \
		--user `id -u`:`id -g` \
		pandoc/core \
		-H web/head.html README.md -o web/readme.html --metadata pagetitle="readme.docker.localhost"
