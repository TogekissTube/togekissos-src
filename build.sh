#!/bin/bash

cd src/arch/x86/loader/stage1
./build.sh
STAGE1_DIR=$(pwd)

cd ../stage2
./build.sh
STAGE2_DIR=$(pwd)

cd ../../../../../

dd if=/dev/zero of=floppy.img bs=512 count=2880
dd if=$STAGE1_DIR/boot.bin of=floppy.img bs=512 count=1 conv=notrunc
dd if=$STAGE2_DIR/stage2.bin of=floppy.img bs=512 count=1 seek=1 conv=notrunc

