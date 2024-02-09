FROM dunglas/frankenphp

RUN apt update -y
RUN apt install -y wget openssh-client git zip curl nginx nodejs npm
RUN IPE_GD_WITHOUTAVIF=1 install-php-extensions pdo_mysql exif pcntl bcmath redis soap gd opcache intl zip


RUN mkdir -p /app
RUN mkdir -p /app/public
RUN echo '<html><head><meta name="robots" content="noindex"></head><body><h1>Woohoo! :)</h1><h3>It works!</h3></body>' > '/app/public/index.php'

RUN ssh-keyscan github.com > /etc/ssh/ssh_known_hosts \
  && dig -t a +short github.com | grep ^[0-9] | xargs -r -n1 ssh-keyscan >> /etc/ssh/ssh_known_hosts

RUN chown -R www-data: /app

WORKDIR /app

EXPOSE 80
EXPOSE 443