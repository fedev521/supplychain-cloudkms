# build stage
FROM golang:1.21 AS builder

WORKDIR /go/src/app

RUN --mount=type=cache,target=/go/pkg/mod/ \
    --mount=type=bind,source=go.sum,target=go.sum \
    --mount=type=bind,source=go.mod,target=go.mod \
    go mod download

ENV CGO_ENABLED=0
RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=bind,target=. \
    go build -o /go/bin/runservice /go/src/app
# RUN --mount=type=cache,target=/root/.cache/go-build \
#     go test -v
# RUN --mount=type=cache,target=/root/.cache/go-build \
#     go vet -v

# package stage
FROM gcr.io/distroless/static-debian12
WORKDIR /
COPY --from=builder /go/bin/runservice .
CMD ["/runservice"]
