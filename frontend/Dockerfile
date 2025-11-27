# Build stage
FROM node:18-alpine AS builder
WORKDIR /app

# Install native build tools needed for modules that use node-gyp
# Use build-base (includes gcc/g++/make) plus linux-headers and python3
RUN apk add --no-cache python3 make g++ libc6-compat
COPY package*.json ./
RUN npm ci --legacy-peer-deps --silent

# Copy package files first for caching
COPY package*.json ./

# Install dependencies with verbose output so CI logs show the real error if it fails
# Consider --legacy-peer-deps only if you hit peer dependency errors
RUN npm ci --no-optional --no-audit --progress=false --verbose

# Copy source and build
COPY . .
RUN npx ng build --configuration=production

# Production stage: serve with nginx
FROM nginx:1.25-alpine

# Copy built Angular files (match angular.json outputPath)
COPY --from=builder /app/dist/angular-15-crud /usr/share/nginx/html

# Remove default nginx config and add custom config
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/frontend.conf /etc/nginx/conf.d/frontend.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]