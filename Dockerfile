FROM alpine:3.9
LABEL maintainer="Sascha Peilicke <sascha@peilicke.de"

ARG google_cloud_sdk=237.0.0

LABEL description="Google Cloud SDK ${google_cloud_sdk} (Firebase, App Engine, etc.)"

ENV SDK_ROOT /opt/google-cloud-sdk
ENV PATH $PATH:${SDK_ROOT}/bin

RUN apk add --no-cache --virtual=.build-dependencies \
        bash \
        python \
        wget
RUN wget \
        --quiet https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${google_cloud_sdk}-linux-x86_64.tar.gz \
        -O /tmp/sdk.tar.gz \
    && tar -xxf /tmp/sdk.tar.gz -C /opt \
    && rm -v /tmp/sdk.tar.gz \
    && ${SDK_ROOT}/install.sh --quiet
RUN gcloud config set disable_usage_reporting true

ENTRYPOINT ["gcloud"]
