
# HTTPS-кеширование APT-пакетов

Кеширование пакетов Ubuntu с использованием **apt-cacher-ng, stunnel, Certbot и Docker Compose**.

**Принцип работы:**

1. Клиент запрашивает пакет через HTTPS.
2. `stunnel` расшифровывает соединение и передаёт запрос в `apt-cacher-ng`.
3. Если пакет уже есть в кеше, он сразу передаётся клиенту.
4. Если пакета нет, прокси скачивает его из Ubuntu, сохраняет и передаёт клиенту.

`Certbot` используется для получения SSL/TLS-сертификата Let's Encrypt.

## Установка

### 1. Клонирование репозитория

```bash
git clone https://github.com/IgoresHKaaa/zerkalo_apt.git
cd zerkalo_apt
```

### 2. Настройка окружения

```bash
cp .env.example .env
nano .env
```

Укажите свои данные:

```dotenv
BACKEND_DOMAIN=
CERTBOT_EMAIL=
```

### 3. Запуск

```bash
chmod +x install.sh
sudo ./install.sh
```

Скрипт проверяет наличие сертификата, при необходимости получает его через Certbot, собирает образ и запускает контейнер `apt-cacher-ng` с HTTPS.

## Проверка работы

Статус контейнера:

```bash
docker compose ps
```

Проверка загрузки файла Ubuntu:

```bash
curl -fSL --path-as-is \
  "https://test.mirror.com/HTTPS///archive.ubuntu.com/ubuntu/dists/noble/InRelease" \
  -o /tmp/ubuntu-InRelease
```

Заменить `test.mirror.com` своим доменом.

Просмотр размера кеша:

```bash
docker exec acng-https du -sh /var/cache/apt-cacher-ng
```
