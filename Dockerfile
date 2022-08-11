# syntax=docker/dockerfile:1
FROM node:16-alpine
RUN npm install -g @angular/cli
WORKDIR /app
COPY . .
RUN npm install 
CMD ["ng", "serve"]
EXPOSE 3000