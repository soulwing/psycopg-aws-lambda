#!/bin/sh

PG_SRC=postgresql-${PG_VER}.tar.gz
PG_URL=https://ftp.postgresql.org/pub/source/v${PG_VER}/${PG_SRC}
PSY_VER_UNDER=$(echo $PSY_VER | sed 's/\./_/g')
PSY_SRC=${PSY_VER_UNDER}.tar.gz
PSY_URL=https://github.com/psycopg/psycopg2/archive/${PSY_SRC}

# all non-zero exits are fatal
set -e

# fetch, validate, and unpack postgresql source
wget --quiet --output-document $PG_SRC $PG_URL
wget --quiet --output-document ${PG_SRC}.sha256 ${PG_URL}.sha256
sha256sum --check ${PG_SRC}.sha256
tar -xf ${PG_SRC}
rm ${PG_SRC}

# fetch and unpack psycopg2 source
wget --quiet --output-document psycopg2.tar.gz $PSY_URL
tar -xf psycopg2.tar.gz
rm psycopg2.tar.gz
