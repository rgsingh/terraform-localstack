ARG version=light
FROM hashicorp/terraform:$version as terraform

FROM golang:alpine AS builder
ARG AWS_PROFILE

COPY --from=terraform  /bin/terraform /bin/
COPY . /go
RUN apk add --no-cache --update docker
RUN AWS_PROFILE="${AWS_PROFILE}" \
  terraform init
WORKDIR .
ENTRYPOINT ["/bin/terraform"]