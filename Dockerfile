FROM node as base

WORKDIR /NodeDocker

### BUILDER ###
FROM base AS builder

COPY *.json .
COPY yarn.lock .
COPY packages/api/*.json ./packages/api/
COPY packages/api/ ./packages/api/

RUN yarn install --pure-lockfile --non-interactive

WORKDIR /NodeDocker/packages/api
RUN yarn build

### RUNNER ###
FROM base

WORKDIR /NodeDocker

COPY *.json .
COPY yarn.lock .

COPY --from=builder /packages/api/*.json ./packages/api/
COPY --from=builder /app/packages/backend/dist ./dist/

ENV NODE_ENV production

RUN yarn install --pure-lockfile --non-interactive --production

WORKDIR /NodeDocker/packages/api

EXPOSE 80
CMD ["node", "dist/index.js"]
