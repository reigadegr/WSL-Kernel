#!/usr/bin/env bash

sudo apt update && sudo apt dist-upgrade -y > /dev/null 2>&1
sudo apt install -y wget build-essential flex bison libssl-dev libelf-dev > /dev/null 2>&1

cd "${GITHUB_WORKSPACE}"

wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.16.9.tar.xz > /dev/null 2>&1
tar xvf linux-5.16.9.tar.xz > /dev/null 2>&1

cd linux-5.16.9

cp ../config .config
scripts/config --disable DEBUG_INFO

CPU_CORES=$(($(grep -c processor < /proc/cpuinfo)*2))
make -j"$CPU_CORES";make modules -j"$CPU_CORES";make modules_install -j"$CPU_CORES";make install -j"$CPU_CORES"

cd ..
mkdir "artifact"
mv linux-5.16.9/arch/x86/boot/bzImage artifact/
