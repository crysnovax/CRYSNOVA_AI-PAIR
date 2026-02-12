FROM node:20-bookworm-slim

# Install git + your media packages **first** (this fixes the git spawn error)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    ffmpeg \
    imagemagick \
    webp \
    && rm -rf /var/lib/apt/lists/*

# Working directory
WORKDIR /usr/src/app

# Copy package files only (for caching)
COPY package*.json ./

# Install project dependencies
RUN npm install

# Install global packages (now git is present)
RUN npm install -g qrcode-terminal pm2

# Copy all other files
COPY . .

# Your port
EXPOSE 5000

# Start command
CMD ["npm", "start"]
