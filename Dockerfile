# Modern Node.js base (no old buster problems)
FROM node:20-bookworm-slim
RUN npm config set registry https://registry.npmjs.org/ \
    && npm config set fetch-retries 5 \
    && npm config set fetch-retry-mintimeout 20000
# Install git - this fixes the npm git spawn error
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# Working directory
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies (now git is available)
RUN npm install

# Optional: add media tools if your bot uses stickers/images/video
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     ffmpeg \
#     webp \
#     imagemagick \
#     && rm -rf /var/lib/apt/lists/*

# Copy all bot files
COPY . .

# Start the bot - change if your main file is not index.js
CMD ["node", "index.js"]
