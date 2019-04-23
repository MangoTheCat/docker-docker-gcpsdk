# Docker with Google Cloud SDK

This docker image install `gcloud` and `kubectrl` on top of the `docker` image. This is used in our CI Pipeline for Google Kubernetes Engine.

## Versions

By default this will use `latest` version of Docker and Google SDK

# Usage

To use this package in your CI, try adding this to your `.gitlab-ci.yml` file:

```
build_docker_image:
    image: adamdeacon/docker-gke
    tags:
        - el7
    stage: build
    only:
        - master
        - tags
    script:
        - docker info
        - export PATH=$PATH:/root/google-cloud-sdk/bin
        - gcloud config set project $PROJECT_ID
        - echo $K8S_SECRET_SERVICE_ACCOUNT > /tmp/$CI_PIPELINE_ID.json
        - gcloud auth activate-service-account --key-file /tmp/$CI_PIPELINE_ID.json
        - gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://gcr.io
        - docker build -t gcr.io/${PROJECT_ID}/${APPNAME}:v${VERSION} .
        - docker push gcr.io/${PROJECT_ID}/${APPNAME}:v${VERSION}
```

## Author

[Adam Deacon](https://github.com/adamjdeacon) for [Mango Solutions](https://www.mango-solutions.com)

Thanks to [Tobias L. Maier](http://tobiasmaier.info)
