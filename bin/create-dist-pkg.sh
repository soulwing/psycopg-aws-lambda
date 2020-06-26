#!/bin/bash

BASE_DIR=$PWD
MODULE_DIR=$PWD/psycopg2-${PSY_VER}/build/lib.linux-x86_64-${PY_VER}
DIST_FILE=psycopg2-aws-lambda-$PY_VER-$PSY_VER.zip

pushd $MODULE_DIR
zip -q $BASE_DIR/$DIST_FILE psycopg2/*
popd
unzip -l $DIST_FILE
