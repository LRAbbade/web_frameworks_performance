FROM python:3.8

ENV PYTHONUNBUFFERED 1

WORKDIR /usr/src/app/
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

ENTRYPOINT [ "gunicorn", "-b", "0.0.0.0:5000", "--workers=5", "--threads", "2", "--worker-tmp-dir", "/dev/shm", "--timeout", "600", "wsgi:app" ]
