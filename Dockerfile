FROM node:20-bookworm

# Install git and system packages FIRST - no slim, full base to avoid surprises
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    ffmpeg \
    imagemagick \
    webp \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install dependencies (git is already there)
RUN npm install

# Install global tools
RUN npm install -g qrcode-terminal pm2

# Copy everything else
COPY . .

EXPOSE 5000

CMD ["npm", "start"]
