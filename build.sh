#!/bin/bash

bash -c "$(curl -fsSL https://raw.githubusercontent.com/BryanDollery/remove-snap/main/remove-snap.sh)"

sudo apt update && sudo apt upgrade -y
sudo apt install -y wget build-essential flex bison libssl-dev libelf-dev dwarves

cd "${GITHUB_WORKSPACE}"

wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.10.11.tar.xz
tar xvf linux-6.10.11.tar.xz

cd linux-6.10.11

cp ../config .config

make olddefconfig
make -j$(nproc)

cd ..
mkdir "artifact"
mv linux-6.10.11/arch/x86/boot/bzImage artifact/
