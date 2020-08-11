FROM alpine:latest

LABEL maintainer="Andre Germann" \
      url="https://buanet.de"

# Install prerequisites
RUN apk add --no-cache curl jq nano

# Create scripts directorys and copy scripts
RUN mkdir -p /opt/scripts/ \
    && chmod 777 /opt/scripts/
COPY entrypoint.sh /opt/scripts/entrypoint.sh \
     && healthcheck.sh /opt/scripts/healthcheck.sh
RUN chmod +x /opt/scripts/entrypoint.sh \
    && chmod +x /opt/scripts/healthcheck.sh

# Healthcheck
HEALTHCHECK --interval=15s --timeout=5s --retries=5 \
    CMD ["/bin/sh", "-c", "/opt/scripts/healthcheck.sh"]

# Run entrypoint-script
ENTRYPOINT ["/bin/sh", "-c", "/opt/scripts/entrypoint.sh"]
