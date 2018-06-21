build:
	@docker build -t wscandy/ci-docker .

clean:
	@-docker rmi wscandy/ci-docker

rebuild: clean build

ci-build:
	@mkdir -p docker_cache
	@docker build -t ${DOCKERHUB_USER}/${IMAGE}:${CIRCLE_TAG} -t ${DOCKERHUB_USER}/${IMAGE} .
	@docker save -o docker_cache/${CIRCLE_TAG}.tar ${DOCKERHUB_USER}/${IMAGE}:${CIRCLE_TAG}
	@docker save -o docker_cache/${IMAGE}.tar ${DOCKERHUB_USER}/${IMAGE}

push:
	@docker login -u ${DOCKERHUB_USER} -p "${DOCKERHUB_PASSWORD}"
	@docker load < docker_cache/${CIRCLE_TAG}.tar
	@docker push ${DOCKERHUB_USER}/${IMAGE}:${CIRCLE_TAG}
	@docker load < docker_cache/${IMAGE}.tar
	@docker push ${DOCKERHUB_USER}/${IMAGE}