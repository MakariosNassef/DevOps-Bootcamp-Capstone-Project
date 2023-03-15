FROM python:3.6
EXPOSE 5002
WORKDIR /app
COPY requirements.txt /app
RUN pip install -r requirements.txt
COPY . /app
CMD python -m flask run --host=0.0.0.0 --port=5002