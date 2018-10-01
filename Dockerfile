###################
## BUILDER IMAGE
###################
FROM node:10.11-alpine AS builder

## Copy source, install dependencies.
WORKDIR /build
COPY . .
RUN yarn install

## Build from source.
RUN yarn build


######################
## PRODUCTION IMAGE
######################
FROM sebp/lighttpd:latest AS production

## Labels:
LABEL maintainer="Steven Xie <hello@stevenxie.me>"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name = "vue-resume"
LABEL org.label-schema.vcs-url="https://github.com/steven-xie/vue-resume"
LABEL org.label-schema.vendor="Steven Xie <hello@stevenxie.me>"

## Install dependencies:
RUN apk update && apk add --no-cache wget

## Copy built application and package metadata.
WORKDIR /var/www/localhost/htdocs/resume
COPY --from=builder /build/dist/ ./

## Define healthcheck.
ENV ENDPOINT=http://0.0.0.0/resume/
COPY scripts/healthcheck.sh /etc/healthcheck.sh
HEALTHCHECK --interval=30s --timeout=30s --start-period=15s --retries=1 \
  CMD sh /etc/healthcheck.sh

## Expose port.
EXPOSE 80
