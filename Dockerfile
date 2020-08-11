FROM alpine:latest

LABEL maintainer="Andre Germann" \
      url="https://buanet.de"

# Install prerequisites
RUN apk add --no-cache curl jq nano

# Create scripts directorys and copy scripts
RUN mkdir -p /opt/scripts/ \
    && chmod 777 /opt/scripts/ \
COPY entrypoint.sh /opt/scripts/entrypoint.sh
RUN chmod +x /opt/scripts/entrypoint.sh

# Healthcheck
HEALTHCHECK --interval=15s --timeout=5s --retries=5 \
    CMD ["/bin/bash", "-c", "/opt/scripts/entrypoint.sh healthcheck"]

# Run entrypoint-script
ENTRYPOINT ["/bin/bash", "-c", "/opt/scripts/entrypoint.sh watchdog"]
