# stage 1 - build process
FROM node:10.9.0-alpine as build-deps
WORKDIR /usr/src/app

# copy package json into workdir
COPY package.json yarn.lock ./
RUN yarn

# copy all source code to workdir
COPY . .
RUN yarn build

# stage 2 - prod env
FROM nginx:1.15-alpine
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
