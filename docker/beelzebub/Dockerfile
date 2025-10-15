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
#
FROM scratch
#
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /root/beelzebub/main /opt/beelzebub/
COPY --from=builder /root/beelzebub/configurations /opt/beelzebub/configurations
#
# Start beelzebub
WORKDIR /opt/beelzebub
USER 2000:2000
ENTRYPOINT ["./main"]
