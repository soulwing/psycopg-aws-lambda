#!/bin/bash

BASE_DIR=$PWD
PG_DIR=postgresql-${PG_VER}
PSY_DIR=psycopg2-${PSY_VER}
PG_PREFIX=$BASE_DIR/build
DIST_FILE=$BASE_DIR/psycopg2-${PY_VER}-${PSY_VER_DOTS}.zip

# all non-zero exits are fatal
set -e

# build postgresql
pushd $PG_DIR
./configure --prefix=$PG_PREFIX --without-readline --without-zlib
make all install
popd

# configure psycopg2
pushd $PSY_DIR
PG_CONFIG=$PG_PREFIX/bin/pg_config
echo $PG_CONFIG
sed "s|^pg_config=.*|pg_config=$PG_CONFIG|; \
     s|^static_libpq=.*|static_libpq=1|" \
     < setup.cfg > setup.cfg.tmp
mv setup.cfg.tmp setup.cfg

# build psycopg2
python${PY_VER} setup.py build

# create distribution zip
pushd build/lib.linux-x86_64-${PY_VER}
zip -q -r $DIST_FILE psycopg2/*
popd 

popd
exit 0
