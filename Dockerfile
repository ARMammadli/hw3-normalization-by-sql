FROM postgres:latest

COPY setup.sql /docker-entrypoint-initdb.d/

ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin
ENV POSTGRES_DB=ada_db

EXPOSE 5432