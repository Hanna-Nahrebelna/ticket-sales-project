FROM python:3.10-slim

# Встановлюємо необхідні пакети для кешування (якщо потрібно)
RUN apt-get update && apt-get install -y \
  build-essential \
  && rm -rf /var/lib/apt/lists/*

# Вказуємо робочу директорію
WORKDIR /app

# Копіюємо вміст папки backend_redis у контейнер
COPY . .

# Оновлюємо pip
RUN pip install --upgrade pip

# Встановлюємо залежності з файлу requirements.txt у папці backend_redis
RUN pip install --no-cache-dir -r requirements.txt

# Запускаємо сервіс
CMD ["python", "manage.py", "runserver", "0.0.0.0:8002"]
