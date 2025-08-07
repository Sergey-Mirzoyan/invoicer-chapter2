FROM golang:latest

# Создание пользователя и группы
RUN addgroup --gid 10001 app && \
    adduser --gid 10001 --uid 10001 \
    --home /app --shell /sbin/nologin \
    --disabled-password app

# Создание директории и копирование файлов
RUN mkdir -p /app/statics/
ADD statics /app/statics/
COPY bin/invoicer /app/invoicer

# Изменение владельца файлов
RUN chown -R app:app /app

# Установка пользователя, рабочего каталога и порта
USER app
WORKDIR /app
EXPOSE 8080

# Команда запуска
ENTRYPOINT ["/app/invoicer"]
