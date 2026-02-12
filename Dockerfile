# Modern Node 20 on Debian Bookworm (current stable)
FROM node:20-bookworm-slim

# Install git + your system packages in one layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    ffmpeg \
    imagemagick \
    webp \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Copy package files first
COPY package*.json ./

# Install project dependencies
RUN npm install

# Install global tools (now git is available)
RUN npm install -g qrcode-terminal pm2

# Copy the rest of the code
COPY . .

# Expose your port
EXPOSE 5000

# Start the app
CMD ["npm", "start"]
