FROM node:20-bookworm-slim

# Install git + your packages in one step (this is the key)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    ffmpeg \
    imagemagick \
    webp \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY package*.json ./

# Install project deps
RUN npm install

# Install global tools (now git exists)
RUN npm install -g qrcode-terminal pm2

COPY . .

EXPOSE 5000

CMD ["npm", "start"]
