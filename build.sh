#!/bin/bash

#export PATH=/prj/qct/llvm/release/internal/HEXAGON/branch-8.7lnx/latest/Tools/bin/:$PATH
#export QEMU_LD_PREFIX=/prj/qct/llvm/release/internal/HEXAGON/branch-8.7lnx/latest/Tools/target/hexagon-linux-musl/

#export PATH=/local/mnt/workspace/vp/checkout/qemu/build_dbg:$PATH
#export PATH=/prj/qct/llvm/release/internal/HEXAGON/branch-8.7lnx/latest/Tools/bin/:$PATH
#export QEMU_LD_PREFIX=/prj/qct/llvm/release/internal/HEXAGON/branch-8.7lnx/latest/Tools/target/hexagon-linux-musl/
#TOOLCHAIN_CMAKE=hexagon-linux-clang.cmake

TOOLCHAIN_CMAKE=hexagon-unknown-linux-musl-clang.cmake
#TOOLS=/pkg/qct/software/llvm/build_tools/clang+llvm-16.0.0-cross-hexagon-unknown-linux-musl/
TOOLS=/local/mnt/workspace/install/clang+llvm-17.0.0-rc3-cross-hexagon-unknown-linux-musl/
#TOOLS=/local/mnt/workspace/install/clang+llvm-17.0.0-rc3-cross-hexagon-unknown-linux-musl/
TOOLS=/prj/qct/llvm/scratch/llvmops_users/bcain/tools/clang+llvm-17.0.0-rc3-cross-hexagon-unknown-linux-musl
export PATH=${TOOLS}/x86_64-linux-gnu/bin/:$PATH
export QEMU_LD_PREFIX=${TOOLS}/x86_64-linux-gnu/target/hexagon-unknown-linux-musl

INSTALL_DEST=/prj/qct/llvm/scratch/llvmops_users/bcain/tmp/whisper

cmake -GNinja \
   -Bbuild_dbg \
   -DWHISPER_BUILD_TESTS=ON \
   -DCMAKE_BUILD_TYPE=RelWithDebInfo \
   -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_CMAKE} \
   -DCMAKE_INSTALL_PREFIX=${INSTALL_DEST} \
   -S$PWD
cmake --build ./build_dbg
cmake --build ./build_dbg -- install

#qemu-hexagon  ./build_dbg/bin/bench -w 1 -t 1
cp -ra ./models ./samples ${INSTALL_DEST}
cd ${INSTALL_DEST}
bsub -I -R "select[ubuntu20_llvm] && rusage[mem=12288]" qemu-hexagon ${INSTALL_DEST}/bin/main -t 6 -f samples/jfk.wav
#qemu-hexagon -cpu any,paranoid-commit-state=on ./build_dbg/bin/bench -w 1 -t 1
