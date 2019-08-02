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

.PHONY: bot
bot:
	while true; do make bot-once; sleep 43200; done

.PHONY: bot-once
bot-once:
	git pull
	./generate.sh
	git add .
	git commit -am "hello, call me m1ch3l" || true
	git push || true

