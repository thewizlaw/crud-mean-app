# build stage: compile native modules
FROM node:20-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN apk add --no-cache python3 make g++ libc6-compat
RUN npm ci --silent

# runtime stage: smaller final image
FROM node:20-alpine AS runtime
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY . .
ENV PORT=8080
EXPOSE 8080
CMD ["node", "server.js"]