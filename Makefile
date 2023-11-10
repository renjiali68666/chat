include .env

.PHONY: all

build:
	docker build -t Chat-GPT .

run:
	export $(cat .env | xargs)
	docker stop Chat-GPT || true && docker rm Chat-GPT || true
	docker run --name Chat-GPT --rm -e OPENAI_API_KEY=${OPENAI_API_KEY} -p 3000:3000 Chat-GPT

logs:
	docker logs -f Chat-GPT

push:
	docker tag Chat-GPT:latest ${DOCKER_USER}/Chat-GPT:${DOCKER_TAG}
	docker push ${DOCKER_USER}/Chat-GPT:${DOCKER_TAG}