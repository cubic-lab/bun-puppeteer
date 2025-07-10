ARG BUN_VERSION=unknown
ARG PUPPETEER_VERSION=unknown

FROM oven/bun:${BUN_VERSION}-debian

ENV \
    # Configure default locale (important for chrome-headless-shell).
    LANG=en_US.UTF-8
    BUN_UID=10042

RUN apt-get update \
    && apt-get install -y --no-install-recommends fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-khmeros \
    fonts-kacst fonts-freefont-ttf dbus dbus-x11

# Add bun.
RUN groupadd -r bun && useradd -u $BUN_UID -rm -g bun -G audio,video bun

USER $BUN_UID

WORKDIR /home/bun

ENV DBUS_SESSION_BUS_ADDRESS autolaunch:

# Install system dependencies as root.
USER root
# Overriding the cache directory to install the deps for the Chrome
# version installed for pptruser. 
RUN PUPPETEER_CACHE_DIR=/home/bun/.cache/puppeteer \
  bunx puppeteer@${PUPPETEER_VERSION} browsers install chrome --install-deps

USER $BUN_UID