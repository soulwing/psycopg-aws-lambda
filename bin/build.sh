#!/bin/bash

BASE_DIR=$PWD
PG_DIR=postgresql-${PG_VER}
PSY_VER_UNDER=$(echo $PSY_VER | sed 's/\./_/g')
PSY_DIR=psycopg2-${PSY_VER_UNDER}
PG_PREFIX=$BASE_DIR/build
DIST_FILE=psycopg${PSY_VER}-${PY_VER}.zip
DIST_PATH=${BASE_DIR}/${DIST_FILE}

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
     s|^static_libpq=.*|static_libpq=1|;" \
     < setup.cfg > setup.cfg.tmp
mv setup.cfg.tmp setup.cfg

# build psycopg2
python${PY_VER} setup.py build

# create distribution zip
pushd build/lib.linux-x86_64-${PY_VER}
zip -q -r $DIST_PATH psycopg2/*
popd 

# return to base dir
popd

# create hashes
sha256sum $DIST_FILE >$DIST_FILE.sha256
md5sum $DIST_FILE >$DIST_FILE.md5
cat $DIST_FILE.sha256
cat $DIST_FILE.md5

exit 0
