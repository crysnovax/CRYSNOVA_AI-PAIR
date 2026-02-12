# Use current Node.js LTS + modern Debian (Bookworm = Debian 12)
FROM node:20-bookworm-slim

# Install required system packages (ffmpeg, imagemagick, webp)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    imagemagick \
    webp \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Copy package.json first (better caching)
COPY package.json .

# Install npm dependencies + global tools
RUN npm install && \
    npm install -g qrcode-terminal pm2

# Copy the rest of your application code
COPY . .

# Expose the port your app listens on (you had 5000)
EXPOSE 5000

# Start command (same as yours)
CMD ["npm", "start"]
