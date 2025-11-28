# backend/Dockerfile
FROM node:20-alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --production --silent
COPY . .
# If you use environment variables to set PORT or DB connection, keep it
ENV PORT=8080
EXPOSE 8080
CMD ["node", "server.js"]