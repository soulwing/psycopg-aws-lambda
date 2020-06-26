#!/bin/bash

set -e

BASE_DIR=$PWD
PG_DIR=postgresql-${PG_VER}
PSY_DIR=psycopg2-${PSY_VER}
PG_PREFIX=$BASE_DIR/build
DIST_FILE=$BASE_DIR/psycopg2-${PY_VER}-${PSY_VER}.zip

pushd $PG_DIR
./configure --prefix=$PG_PREFIX --without-readline --without-zlib
make all install
popd

pushd $PSY_DIR
PG_CONFIG=$PG_PREFIX/bin/pg_config
echo $PG_CONFIG
sed "s|^pg_config=.*|pg_config=$PG_CONFIG|; s|^static_libpq=.*|static_libpq=1|" <setup.cfg >setup.cfg.tmp
mv setup.cfg.tmp setup.cfg
python3 setup.py build


pushd build/lib.linux-x86_64-${PY_VER}
zip -q -r $DIST_FILE psycopg2/*
popd 

popd
unzip -l $DIST_FILE

popd
