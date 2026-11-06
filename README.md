
## Установка

### 1. Настройка окружения

Создайте файл `.env`:

```bash
cp .env.example .env
nano .env
```

Заполните переменные:

```dotenv
BACKEND_DOMAIN=mirror.example.com
CERTBOT_EMAIL=admin@example.com
```

### 3. Запуск установки

```bash
chmod +x install.sh
sudo ./install.sh
```
