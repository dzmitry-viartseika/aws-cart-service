FROM node:16-alpine As development

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci

COPY . .

USER node

FROM node:16-alpine As build

WORKDIR /usr/src/app

COPY package*.json ./

COPY --from=development /usr/src/app/node_modules ./node_modules

COPY . .

RUN npm run build

ENV NODE_ENV production

RUN npm ci --only=production && npm cache clean --force

USER node

FROM node:16-alpine As production

EXPOSE 4000

COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/dist ./dist

CMD [ "node", "dist/main.js" ]