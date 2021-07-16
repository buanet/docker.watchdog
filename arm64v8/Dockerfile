FROM balenalib/aarch64-alpine:latest

#Labeling Docker image
LABEL org.opencontainers.image.title="Docker watchdog" \
      org.opencontainers.image.description="Simple watchdog for monitoring container health status" \
      org.opencontainers.image.authors="info@buanet.de" \
      org.opencontainers.image.url="https://github.com/buanet/docker.watchdog" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.created="${DATI}"

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
