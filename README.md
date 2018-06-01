# Docker CI - Docker Client
[![CircleCI](https://circleci.com/gh/WsCandy/ci-docker.svg?style=shield)](https://circleci.com/gh/WsCandy/ci-docker)

This docker image contains the Docker Client, if you wish to create docker images, and push them to DockerHub on CircleCI then this is the container for you!

## Usage

In your `.circleci/config.yml` simply add the following steps to setup the remote docker client:

    - setup_remote_docker:
        docker_layer_caching: true
    - run:
        name: Build Image
        command: |
          VER=1.0.0
          TAG=$VER.$CIRCLE_BUILD_NUM
          docker build -t $DOCKERHUB_USER/repo-name:$TAG .
          docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD
          docker push $DOCKERHUB_USER/repo-name:$TAG
          
Be sure to set the `DOCKERHUB_USER` and `DOCKERHUB_PASSWORD` env variables.