FROM debian:12 AS nodejs-my-website

LABEL org.opencontainers.image.source=https://github.com/alexispe/cda242-next

RUN apt-get update -yq \
&& apt-get install curl gnupg -yq \
&& curl -sL https://deb.nodesource.com/setup_24.x | bash \
&& apt-get install nodejs -yq \
&& apt-get clean -y

ADD . /app/

WORKDIR /app

RUN npm install
RUN npm run build

EXPOSE 3000

COPY docker/next/entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

ENTRYPOINT [ "entrypoint" ]
CMD [ "npm", "run", "start" ]

