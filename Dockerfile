FROM node:24.2-alpine3.21 AS builder


ADD . /app/

WORKDIR /app

RUN npm install
RUN npm run build

FROM node:24.2-alpine3.21 AS next

LABEL org.opencontainers.image.source=https://github.com/alexispe/cda242-next

COPY --from=builder /app/public ./public

COPY --from=builder /app/.next/standalone /app/
COPY --from=builder /app/.next/static /app/.next/static

WORKDIR /app
EXPOSE 3000

COPY docker/next/entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

ENTRYPOINT [ "entrypoint" ]
CMD ["node", "server.js"]

