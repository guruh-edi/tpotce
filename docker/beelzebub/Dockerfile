FROM golang:1.24-alpine AS builder
#
ENV GO111MODULE=on \
  CGO_ENABLED=0 \
  GOOS=linux
#
# Install packages
RUN apk -U add git
#
WORKDIR /root
#
# Build beelzebub
RUN git clone -b guruh-edi/simulate-fs https://github.com/guruh-edi/beelzebub && cd beelzebub
WORKDIR /root/beelzebub
RUN go mod download
RUN go build -o main .
COPY configurations configurations
#
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y fuse3 rsync
RUN mkdir -p /opt/honeypot/actual-root /opt/honeypot/mnt
#
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /root/beelzebub/main /opt/beelzebub/
COPY --from=builder /root/beelzebub/configurations /opt/beelzebub/configurations

RUN rsync -a /bin /lib /usr/bin /etc /opt/honeypot/actual-root

# Start beelzebub
WORKDIR /opt/beelzebub
USER 2000:2000
ENTRYPOINT ["./main"]
