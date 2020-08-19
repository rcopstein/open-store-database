FROM postgres:alpine

# Initializes the database on creation
COPY ./db-init.sql /docker-entrypoint-initdb.d

# Adds default products to the database
# Comment if you want an unseeded database
COPY ./db-seed.sql /docker-entrypoint-initdb.d

CMD ["postgres"]