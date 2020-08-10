FROM alpine:latest

RUN apk add --no-cache curl jq

COPY entrypoint /
ENTRYPOINT ["/entrypoint"]

HEALTHCHECK --interval=15s CMD /entrypoint healthcheck

CMD ["watchdog"]
