FROM node:20-alpine AS builder

WORKDIR /item

RUN apk add --no-cache git python3 make g++

RUN git clone https://github.com/EvolutionAPI/evolution-api.git .

RUN npm install -g pnpm && \
    pnpm config set block-exotic-subdeps false && \
    pnpm install --no-frozen-lockfile

RUN pnpm build

FROM node:20-alpine

WORKDIR /item

RUN apk add --no-cache ffmpeg

COPY --from=builder /item/dist ./dist
COPY --from=builder /item/node_modules ./node_modules
COPY --from=builder /item/package.json ./package.json

EXPOSE 8080

CMD ["node", "dist/src/main.js"]
