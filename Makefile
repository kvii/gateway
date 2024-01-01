VERSION=$(shell git describe --tags --always)
API_PROTO_FILES=$(shell find api -name *.proto)

.PHONY: api
# generate api proto
api:
	protoc --proto_path=./api \
 	       --go_out=paths=source_relative:./api \
	       $(API_PROTO_FILES)

.PHONY: push-github
push-github:
	docker buildx build --platform linux/amd64,linux/arm64 --push -t ghcr.io/kvii/gateway:$(VERSION) .

.PHONY: push
push:
	docker buildx build --platform linux/amd64,linux/arm64 --push -t kvii2202/gateway:$(VERSION) .
