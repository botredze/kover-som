# Stage 1: Build the React app
FROM node:14-alpine as build

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Use Nginx to serve the built React app
FROM nginx:alpine

# Copy the build output from the build stage to the Nginx directory
COPY --from=build /usr/src/app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
