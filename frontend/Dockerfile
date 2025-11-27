# frontend/Dockerfile
# Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
COPY package-lock.json ./
RUN npm ci --silent
COPY . .
RUN npm run build -- --output-path=./dist --configuration=production

# Production stage: serve with nginx
FROM nginx:1.25-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
# Remove default nginx config and use our minimal one (optional)
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/frontend.conf /etc/nginx/conf.d/frontend.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
