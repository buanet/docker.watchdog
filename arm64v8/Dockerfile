FROM balenalib/aarch64-alpine:latest

LABEL maintainer="Andre Germann" \
      url="https://buanet.de"

# Install prerequisites
RUN apk add --no-cache curl jq nano tzdata

# Create scripts directorys and copy scripts
RUN mkdir -p /opt/scripts/
COPY scripts/run.sh /opt/scripts/run.sh
COPY scripts/healthcheck.sh /opt/scripts/healthcheck.sh
RUN chmod +x /opt/scripts/run.sh \
    && chmod +x /opt/scripts/healthcheck.sh

ENV TZ="Europe/Berlin"

# Healthcheck
HEALTHCHECK --interval=15s --timeout=5s --retries=5 \
    CMD ["/bin/sh", "-c", "/opt/scripts/healthcheck.sh"]

# Run entrypoint-script
ENTRYPOINT ["/bin/sh", "-c", "/opt/scripts/run.sh"]
