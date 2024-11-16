# Використовуємо Python 3.10 як базовий образ
FROM python:3.10-slim

# Оновлюємо систему і встановлюємо залежності для Postgres
RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  && rm -rf /var/lib/apt/lists/*

# Встановлюємо робочу директорію /app
WORKDIR /app

# Копіюємо вміст поточної папки backend_rds у контейнер
COPY . .

# Перевіряємо, чи всі файли правильно скопіювалися
RUN ls -l /app

# Оновлюємо pip
RUN pip install --upgrade pip

# Встановлюємо залежності з requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Вказуємо команду для запуску сервісу
CMD ["python", "manage.py", "runserver", "0.0.0.0:8001"]
