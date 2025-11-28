FROM node:20-alpine AS build
WORKDIR /usr/src/app

# Install dependencies needed for native modules
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    libc6-compat

# Copy package files
COPY package*.json ./

# Install ALL dependencies (including devDependencies) in case they're needed for builds
RUN npm ci

# Copy source code
COPY . .

# Production runtime stage
FROM node:20-alpine AS runtime
WORKDIR /usr/src/app

# Copy only production node_modules
COPY package*.json ./
RUN npm ci --production --omit=dev

# Copy application code
COPY --from=build /usr/src/app .

# Set environment
ENV NODE_ENV=production
ENV PORT=8080

EXPOSE 8080

# Use non-root user for security
USER node

CMD ["node", "server.js"]