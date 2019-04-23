ARG DOCKER_VERSION=latest
FROM docker:${DOCKER_VERSION}

RUN apk add --update python curl which bash
RUN curl -sSL https://sdk.cloud.google.com | bash
RUN export PATH=$PATH:/root/google-cloud-sdk/bin
RUN /root/google-cloud-sdk/bin/gcloud components install kubectl

LABEL \
  org.opencontainers.image.authors="Adam Deacon" \
  org.opencontainers.image.description="This docker image installs GCP SDK and kubectl" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.source="https://github.com/adamjdeacon/docker-gek" \
  org.opencontainers.image.title="Docker Compose on docker base image" \
  org.opencontainers.image.version="${DOCKER_VERSION} with GCP SDK"
