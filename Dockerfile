FROM golang:1.22.5 AS builder

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o kmsg .


FROM scratch

COPY --from=builder /build/kmsg /

ENTRYPOINT [ "/kmsg" ]
