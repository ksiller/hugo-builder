FROM alpine:3.11.6
LABEL org.opencontainers.image.source=https://github.com/ksiller/hugo-builder

WORKDIR /root/
ENV AWS_DEFAULT_REGION us-east-1
ARG HUGO_VERSION=0.79.0

# Update, install Git and things
RUN apk update && \
    apk add \ 
        py-pip \
        git \
        python2-dev \
        py-yuicompressor \
        coreutils \
        libstdc++ npm && \
    rm -rf /var/cache/apk/*

# Install tools
RUN pip install setuptools awscli && \
    npm install -g html-minifier

# Install Hugo
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz hugo-${HUGO_VERSION}.tar.gz
RUN tar -xzf hugo-${HUGO_VERSION}.tar.gz && \
    mv hugo /usr/local/bin/hugo-${HUGO_VERSION} && \
    rm hugo-${HUGO_VERSION}.tar.gz && \
    #ls /usr/local/bin/ && \
    ln -s /usr/local/bin/hugo-${HUGO_VERSION} /usr/local/bin/hugo

# Copy in script
#COPY build-site.sh /root/build-site.sh
#RUN chmod +x /root/build-site.sh
