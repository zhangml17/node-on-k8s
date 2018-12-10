SHELL=/bin/bash
LOCAL_REGISTRY=192.168.100.167/test
NAME=node-web-demo
TAG=v1
IMAGE=${LOCAL_REGISTRY}/${NAME}:${TAG}
URL=gmt.nodetest.me
MANIFEST=./manifest
SCRIPT=./scripts


all: build push deploy


build:
	@docker build -t ${IMAGE} .
push:
	@docker push ${IMAGE}
sed:
	@find ${MANIFEST} -type f -name "*.yaml" | xargs sed -i s?"{{.name}}"?"${NAME}"?g
	@find ${MANIFEST} -type f -name "*.yaml" | xargs sed -i s?"{{.image}}"?"${IMAGE}"?g
	@find ${MANIFEST} -type f -name "*.yaml" | xargs sed -i s?"{{.url}}"?"${URL}"?g
deploy: export OP=create
deploy: sed
	@kubectl ${OP} -f ${MANIFEST}/deployment.yaml
	@kubectl ${OP} -f ${MANIFEST}/service.yaml
	@kubectl ${OP} -f ${MANIFEST}/ingress.yaml
clean: export OP=delete
clean:
	-@kubectl ${OP} -f ${MANIFEST}/deployment.yaml
	-@kubectl ${OP} -f ${MANIFEST}/service.yaml
	-@kubectl ${OP} -f ${MANIFEST}/ingress.yaml
