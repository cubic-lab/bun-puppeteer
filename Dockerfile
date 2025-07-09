ARG BUN_VERSION=latest
ARG PUPPETEER_VERSION=latest

FROM oven/bun:${BUN_VERSION}

RUN bunx puppeteer@${PUPPETEER_VERSION} browsers install chrome

USER bun