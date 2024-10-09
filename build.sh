#!/bin/bash

bash -c "$(curl -fsSL https://raw.githubusercontent.com/BryanDollery/remove-snap/main/remove-snap.sh)"

sudo apt update && sudo apt upgrade -y
sudo apt install -y wget build-essential flex bison libssl-dev libelf-dev dwarves

cd "${GITHUB_WORKSPACE}"

wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.102.tar.xz
tar xvf linux-5.10.102.tar.xz

cd linux-5.10.102*

cp ../config .config

make -j$(nproc)

cd ..
mkdir "artifact"
mv linux-5.10.102*/arch/x86/boot/bzImage artifact/
