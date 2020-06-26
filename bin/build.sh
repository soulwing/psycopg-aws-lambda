#!/bin/bash

PG_DIR=postgresql-${PG_VER}
PSY_DIR=psycopg2-${PSY_VER}
PG_PREFIX=$PWD/build

pushd $PG_DIR
./configure --prefix=$PG_PREFIX --without-readline --without-zlib
make all install
popd

pushd $PSY_DIR
popd
