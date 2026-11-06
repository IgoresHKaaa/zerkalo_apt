#!/bin/bash
set -e

cd "$(dirname "$0")"

set -a
source .env
set +a

echo "Проверяем SSL-сертификат..."

if [ -s "./letsencrypt/live/$BACKEND_DOMAIN/fullchain.pem" ] && \
   [ -s "./letsencrypt/live/$BACKEND_DOMAIN/privkey.pem" ]; then
    echo "Сертификат уже существует. Пропускаем Certbot."
else
    echo "Получаем SSL-сертификат..."

    docker compose -f docker-compose.certbot.yml \
      run --rm --service-ports certbot
fi

echo "Запускаем apt-cacher-ng..."

docker compose up -d --build

echo "Проверяем контейнеры..."
docker compose ps

echo "Установка завершена"
