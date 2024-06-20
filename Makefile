SHELL := /bin/bash
OCI_BIN := /usr/bin/podman
BUILD_OPTS :=
IMAGE_REG := quay.io
IMAGE_NAMESPACE := fedora-sig-robotics/ros2-cs9-env
IMAGE_TAG := latest
IMAGE := ${IMAGE_REG}/${IMAGE_NAMESPACE}:${IMAGE_TAG}


.PHONY: image/build
image/build:
	${OCI_BIN}  build ${BUILD_OPTS} -t ${IMAGE} .

.PHONY: image
image: image/build
