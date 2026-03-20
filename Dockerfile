# Этап 1: Установка зависимостей
FROM node:20-alpine AS dependencies
WORKDIR /usr/src/app
COPY package*.json ./
# Используем npm ci для более быстрой и предсказуемой установки в CI/CD
RUN npm ci --only=production

# Этап 2: Финальный образ для запуска
FROM node:20-alpine
WORKDIR /usr/src/app

# Настройка переменных окружения
ENV NODE_ENV=production
# Azure App Service будет прокидывать переменную PORT
ENV PORT=3000

# Копируем зависимости из первого этапа
COPY --from=dependencies /usr/src/app/node_modules ./node_modules

# Копируем исходный код приложения
# Файлы, указанные в .dockerignore (например, локальный node_modules), будут пропущены
COPY . .

# Открываем порт (Azure App Service использует PORT по умолчанию)
EXPOSE 3000

# Команда запуска
CMD [ "node", "index.js" ]
