SERVER_OPTS ?= --baseURL=/ --appendPort=false

.PHONY: dev
dev: $(DEPS)
	hugo server -D -F --disableFastRender --bind=0.0.0.0 $(SERVER_OPTS)

.PHONY: build
build: $(DEPS)
	hugo --gc --minify

.PHONY: build-thumbnails
build-thumbnails:
	hugo --gc
	./generate-thumbnails.sh

.PHONY: netlify-dev
netlify-dev:
	netlify dev -c 'make dev'

.PHONY: bot
bot:
	while true; do make bot-once; sleep 86400; done

.PHONY: bot-once
bot-once:
	git pull
	docker pull moul/pipotron
	docker pull ultreme/jargon-generator
	./generate.sh
	make build-thumbnails
	git add .
	git commit -am "hello, call me m1ch3l" || true
	git push || true
