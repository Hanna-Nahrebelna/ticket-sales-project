FROM python:3.11-slim

WORKDIR /app

# Копіюємо файл requirements.txt до контейнера
COPY requirements.txt /app/

# Встановлюємо залежності з requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Копіюємо весь контекст проєкту у контейнер
COPY . .

# Запускаємо додаток
CMD ["python", "app.py"]
