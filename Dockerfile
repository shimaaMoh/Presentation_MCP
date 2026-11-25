# Multi-platform Linux container for RCMC Presentation MCP Server
FROM node:20-bookworm-slim

# Install prerequisites & PowerShell Core (pwsh)
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    curl \
    gnupg \
    && wget -q "https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb" \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y --no-install-recommends powershell \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy application files
COPY package*.json ./
COPY assets/ ./assets/
COPY src/ ./src/

# Create output directory for generated presentations
RUN mkdir -p /app/output

ENV NODE_ENV=production
ENV PORT=8080
EXPOSE 8080

CMD ["node", "src/http_server.js"]
