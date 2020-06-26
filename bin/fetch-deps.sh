#!/bin/sh

PG_SRC=https://ftp.postgresql.org/pub/source/v${PG_VER}/postgresql-${PG_VER}.tar.gz
PSY_SRC=https://github.com/psycopg/psycopg2/archive/${PSY_VER}.tar.gz

wget -O postgresql.tar.gz $PG_SRC
wget -O psycopg2.tar.gz $PSY_SRC
tar -xf postgresql.tar.gz
tar -xf psycopg2.tar.gz
rm postgresql.tar.gz psycopg2.tar.gz
