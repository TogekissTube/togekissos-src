cd src/arch/x86/loader/stage1
./build.sh
cd ..
cd stage2
./build.sh 
mv src/arch/x86/loader/stage1/boot.bin src/arch/x86/loader/stage2/stage2.bin ../../../../../
cd ../../../../../
dd if=/dev/zero of=floppy.img bs=512 count=2880
dd if=boot.bin of=floppy.img bs=512 count=1 conv=notrunc
dd if=stage2.bin of=floppy.img bs=512 count=1 seek=1 conv=notrunc

