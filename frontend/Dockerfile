# Build stage
FROM node:20-alpine AS builder
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci --production --silent

# Copy the rest of the code
COPY . .

# Build the Angular project (outputs to /app/dist)
RUN npx ng build --output-path=./dist --configuration=production

# Production stage: serve with nginx
FROM nginx:1.25-alpine

# Copy built Angular files
COPY --from=builder /app/dist /usr/share/nginx/html

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Custom nginx config
COPY nginx/frontend.conf /etc/nginx/conf.d/frontend.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
