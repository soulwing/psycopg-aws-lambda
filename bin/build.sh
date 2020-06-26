#!/bin/bash

PG_DIR=postgresql-${PG_VER}
PSY_DIR=psycopg2-${PSY_VER}
PG_PREFIX=$PWD/build

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
popd
