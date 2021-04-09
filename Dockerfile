FROM node:14 as build

ENV APP_ENV production
WORKDIR /app
COPY . ./
RUN mv .env.production .env
RUN yarn install
RUN yarn build

# production environment
FROM nginx:stable-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]