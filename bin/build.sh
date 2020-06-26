#!/bin/bash

set -e

BASE_DIR=$PWD
PG_DIR=postgresql-${PG_VER}
PSY_DIR=psycopg2-${PSY_VER}
PG_PREFIX=$BASE_DIR/build
psy_ver_dots=$(echo $PSY_VER | sed 's/_/./g')
DIST_FILE=$BASE_DIR/psycopg2-${PY_VER}-${psy_ver_dots}.zip

pushd $PG_DIR
./configure --prefix=$PG_PREFIX --without-readline --without-zlib
make all install
popd

pushd $PSY_DIR
PG_CONFIG=$PG_PREFIX/bin/pg_config
echo $PG_CONFIG
sed "s|^pg_config=.*|pg_config=$PG_CONFIG|; s|^static_libpq=.*|static_libpq=1|" <setup.cfg >setup.cfg.tmp
mv setup.cfg.tmp setup.cfg
python${PY_VER} setup.py build


pushd build/lib.linux-x86_64-${PY_VER}
zip -q -r $DIST_FILE psycopg2/*
popd 
popd

unzip -l $DIST_FILE
