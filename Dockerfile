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
FROM stevenxie/junior:latest AS production

## Labels:
LABEL maintainer="Steven Xie <hello@stevenxie.me>"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name = "vue-resume"
LABEL org.label-schema.vcs-url="https://github.com/steven-xie/vue-resume"
LABEL org.label-schema.vendor="Steven Xie <hello@stevenxie.me>"

## Copy built application and package metadata.
WORKDIR /www/resume/
COPY --from=builder /build/dist/ ./

## Configure environment, define healthcheck endpoint:
ENV PORT=80 TRAILING_SLASH=false ENDPOINT=http://0.0.0.0/resume

## Expose default port.
EXPOSE $PORT
