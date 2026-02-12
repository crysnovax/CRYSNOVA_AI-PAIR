# Use a current, supported Node.js version (Node 20 LTS + Debian 12 Bookworm)
FROM node:20-bookworm-slim

# Set working directory inside the container
WORKDIR /app

# Copy package files first (this makes builds faster when code changes)
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# If you need ffmpeg, webp, imagemagick (for stickers, media processing, etc.)
# Uncomment the next block if you actually use these tools in your bot
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     ffmpeg \
#     webp \
#     imagemagick \
#     && rm -rf /var/lib/apt/lists/*

# Copy the rest of your bot files
COPY . .

# The command to start your bot
# Change "index.js" to your actual entry file if it's different (e.g. bot.js, start.js)
CMD ["node", "index.js"]
