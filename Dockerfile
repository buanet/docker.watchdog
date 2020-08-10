FROM alpine:latest

RUN apk add --no-cache curl jq

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

HEALTHCHECK --interval=15s CMD /entrypoint.sh healthcheck

CMD ["watchdog"]
