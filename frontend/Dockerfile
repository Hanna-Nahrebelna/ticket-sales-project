# Dockerfile для frontend

# Використовуємо базовий образ Python 3.10
FROM python:3.10-slim

# Встановлюємо залежності для системи
RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  && rm -rf /var/lib/apt/lists/*

# Встановлюємо робочу директорію
WORKDIR /app

# Копіюємо вміст поточної папки в контейнер
COPY . .

# Оновлюємо pip
RUN pip install --upgrade pip

# Встановлюємо залежності з файлу requirements.txt у папці frontend
RUN pip install --no-cache-dir -r requirements.txt

# Запускаємо сервіс
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

