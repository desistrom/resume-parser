FROM python:3.7.13
WORKDIR /app
RUN apt-get update && \
    apt-get install -y wget zip unzip
ADD ./deployment/requirements.txt /app
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install --no-cache-dir gunicorn 
RUN apt-get update && \
apt-get install -y --no-install-recommends default-jdk && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir tika
COPY ./deployment/ /app
COPY ./generated_model/ /app/generated_model
EXPOSE 5000
ENV FLASK_APP=app.py
ENTRYPOINT [ "flask"]
CMD [ "run", "--host", "0.0.0.0" ]