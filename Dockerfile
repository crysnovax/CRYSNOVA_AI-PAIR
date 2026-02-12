FROM node:20-bookworm-slim

# Install git (fixes the npm git error)
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./

RUN npm install

# Optional: uncomment if you need ffmpeg/webp/imagemagick later
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     ffmpeg \
#     webp \
#     imagemagick \
#     && rm -rf /var/lib/apt/lists/*

COPY . .

CMD ["node", "index.js"]
