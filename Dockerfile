FROM node as base

WORKDIR /nodedocker

### BUILDER ###
FROM base AS builder

COPY *.json .
COPY yarn.lock .
COPY packages/api/*.json ./packages/api/
COPY packages/api/ ./packages/api/

RUN yarn install --pure-lockfile --non-interactive

WORKDIR /nodedocker/packages/api
RUN yarn build

### RUNNER ###
FROM base

WORKDIR /nodedocker

COPY *.json .
COPY yarn.lock .

COPY --from=builder /nodedocker/packages/api/*.json ./packages/api/
COPY --from=builder /nodedocker/packages/api/dist ./packages/api/dist/

ENV NODE_ENV production

RUN yarn install --pure-lockfile --non-interactive --production

WORKDIR /nodedocker/packages/api

EXPOSE 4000
CMD ["node", "dist/index.js"]
