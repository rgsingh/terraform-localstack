ARG version=light
FROM hashicorp/terraform:$version as terraform

FROM golang:alpine AS builder
ARG AWS_PROFILE

COPY --from=terraform  /bin/terraform /bin/
RUN mkdir -p /go/lambda/app
COPY resource/ /go
COPY lambda/app/* /go/lambda/app/
COPY lambda/* /go/lambda/
RUN apk add --no-cache --update docker
RUN AWS_PROFILE="${AWS_PROFILE}" \
  terraform init -backend-config=/go/org-tf-state.tfbackend
WORKDIR .
ENTRYPOINT ["/bin/terraform"]