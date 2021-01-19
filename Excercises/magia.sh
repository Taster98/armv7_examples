#!/bin/bash
# TUTORIAL:
# ./magia.sh nome_sorgente nome_eseguibile

FILE_SRC=$1

FILE_NAME=$2

arm-linux-gnueabihf-gcc $FILE_SRC -static -ggdb3 -o $FILE_NAME

qemu-arm -g 12345 $FILE_NAME &

gdb-multiarch -q --nh -ex "set architecture arm" -ex "file ${FILE_NAME}" -ex "target remote localhost:12345"
