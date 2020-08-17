FROM arm64v8/debian:buster-slim

LABEL maintainer="Andre Germann" \
      url="https://buanet.de"

# Install prerequisites
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Create scripts directorys and copy scripts
RUN mkdir -p /opt/scripts/
COPY scripts/run.sh /opt/scripts/run.sh
COPY scripts/healthcheck.sh /opt/scripts/healthcheck.sh
RUN chmod +x /opt/scripts/run.sh \
    && chmod +x /opt/scripts/healthcheck.sh

ENV TZ="Europe/Berlin"

# Healthcheck
HEALTHCHECK --interval=15s --timeout=5s --retries=5 \
    CMD ["/bin/bash", "-c", "/opt/scripts/healthcheck.sh"]

# Run entrypoint-script
ENTRYPOINT ["/bin/bash", "-c", "/opt/scripts/run.sh"]
