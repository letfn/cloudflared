SHELL := /bin/bash

menu:
	@perl -ne 'printf("%10s: %s\n","$$1","$$2") if m{^([\w+-]+):[^#]+#\s(.+)$$}' Makefile

build: # Build defn/cloudflared
	docker build -t defn/cloudflared $(build) .

push: # Push defn/cloudflared
	docker push defn/cloudflared

pull : # Pull defn/cloudflared
	docker pull defn/cloudflared

bash: # Run bash shell with defn/cloudflared
	docker run --rm -ti --entrypoint bash defn/cloudflared

clean:
	docker-compose down --remove-orphans

up:
	docker-compose up -d --remove-orphans

down:
	docker-compose rm -f -s

recreate:
	$(MAKE) clean
	$(MAKE) up

logs:
	docker-compose logs -f
