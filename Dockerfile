ARG POSTGRES_IMAGE_TAG=12-alpine
FROM postgres:${POSTGRES_IMAGE_TAG}
COPY create-multiple-postgresql-databases.sh /docker-entrypoint-initdb.d/
