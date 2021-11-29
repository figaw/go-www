app = go-www

.PHONY:
devrun:
	docker run --rm \
	--name $(app) \
	-v $(PWD)/app:/mnt/app \
	-w /mnt/app \
	-p 8080:8080 \
	golang:1.16-alpine go run main.go

.PHONY:
devrun-port-test:
	docker run --rm \
	--name $(app) \
	-v $(PWD)/app:/mnt/app \
	-w /mnt/app \
	-e PORT=3000 \
	-p 8080:3000 \
	golang:1.16-alpine go run main.go

.PHONY:
drerun:
	make dclean
	make devrun

.PHONY:
build:
	docker build -t $(app):dev .

.PHONY:
br: # build and run
	make build
	docker run -d --rm \
	--name $(app) \
	-e PORT=3000 \
	-p 8080:3000 \
	$(app):dev

.PHONY:
brr: # build and rerun
	make dclean
	make br

.PHONY:
dclean: # docker clean
	docker rm -f $(app)

.PHONY:
ginit:
	docker run --rm \
	-it \
	--name $(app) \
	-v $(PWD)/app:/mnt/app \
	-w /mnt/app \
	golang:1.16-alpine
