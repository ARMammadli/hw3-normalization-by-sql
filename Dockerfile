FROM postgres:latest

RUN apt-get update && apt-get install -y gnumeric

COPY setup.sql /docker-entrypoint-initdb.d/

COPY load_data.sh /usr/local/bin/load_data.sh
RUN chmod +x /usr/local/bin/load_data.sh

ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin
ENV POSTGRES_DB=ada_db

EXPOSE 5432

CMD ["postgres"]