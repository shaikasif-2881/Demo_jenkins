FROM node:18 as build
WOKDIR /app
COPY package*.Jason ./
RUN npm install 
COPY . .
RUN npm run build
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
