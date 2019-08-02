SERVER_OPTS ?= --baseURL=/ --appendPort=false

.PHONY: dev
dev: $(DEPS)
	hugo server -D -F --disableFastRender --bind=0.0.0.0 $(SERVER_OPTS)

.PHONY: build
build: $(DEPS)
	hugo --gc --minify

.PHONY: netlify-dev
netlify-dev:
	netlify dev -c 'make dev'
