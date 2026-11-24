FROM node:bookworm-slim
ENV NODE_ENV=production

WORKDIR /app

RUN npm install -g pnpm@10.33.0

# Everything pnpm needs to resolve dependencies must exist before install:
# package.json depends on tarballs in vendor/ and applies a patch from patches/.
COPY package.json pnpm-lock.yaml ./
COPY vendor ./vendor
COPY patches ./patches

RUN pnpm install

COPY . .

CMD [ "node", "src/server.js" ]
