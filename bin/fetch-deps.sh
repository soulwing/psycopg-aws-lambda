#!/bin/sh

PG_VER=10.9
PSY_VER=2_8_5
PG_SRC=https://ftp.postgresql.org/pub/source/v${PG_VER}/postgresql-${PG_VER}.tar.gz
PSY_SRC=https://github.com/psycopg/psycopg2/archive/${PSY_VER}.tar.gz

wget -O postgresql.tar.gz $PG_SRC
wget -O psycopg2.tar.gz $PSY_SRC
