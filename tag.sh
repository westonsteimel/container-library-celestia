#!/bin/sh

VERSION=$(grep -e "ARG CELESTIA_VERSION=" Dockerfile)
VERSION=${VERSION#ARG CELESTIA_VERSION=\"}
VERSION=${VERSION%\"}
echo "Tagging version ${VERSION}"
docker tag "${DOCKER_USERNAME}/celestia:latest" "${DOCKER_USERNAME}/celestia:${VERSION}"
docker tag "${DOCKER_USERNAME}/celestia:latest" "${DOCKER_USERNAME}/celestia:master"
