FROM nginx:latest

ENV TERM xterm

# Dev tools
RUN apt-get update && apt-get install -y mc nano vim && rm -r /var/lib/apt/lists/*

RUN groupadd -r symfony && useradd -r -g symfony -s /bin/bash -m symfony

ADD snippets /etc/nginx/snippets
ADD ssl /etc/nginx/ssl
ADD conf.d /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/
COPY sites/f4u-test.conf /etc/nginx/sites-enabled/

RUN rm /etc/nginx/conf.d/default.conf

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
