#!/bin/sh

PG_SRC=https://ftp.postgresql.org/pub/source/v${PG_VER}/postgresql-${PG_VER}.tar.gz
PSY_SRC=https://github.com/psycopg/psycopg2/archive/${PSY_VER}.tar.gz

# fetch and unpack postgresql source
wget --quiet --output-document postgresql.tar.gz $PG_SRC
tar -xf postgresql.tar.gz
rm postgresql.tar.gz

# fetch and unpack psycopg2 source
wget --quiet --output-document psycopg2.tar.gz $PSY_SRC
tar -xf psycopg2.tar.gz
rm psycopg2.tar.gz
