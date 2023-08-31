#!/bin/bash

#export PATH=/prj/qct/llvm/release/internal/HEXAGON/branch-8.7lnx/latest/Tools/bin/:$PATH
#export QEMU_LD_PREFIX=/prj/qct/llvm/release/internal/HEXAGON/branch-8.7lnx/latest/Tools/target/hexagon-linux-musl/

#export PATH=/local/mnt/workspace/vp/checkout/qemu/build_dbg:$PATH
#export PATH=/prj/qct/llvm/release/internal/HEXAGON/branch-8.7lnx/latest/Tools/bin/:$PATH
#export QEMU_LD_PREFIX=/prj/qct/llvm/release/internal/HEXAGON/branch-8.7lnx/latest/Tools/target/hexagon-linux-musl/
TOOLS=/pkg/qct/software/llvm/build_tools/clang+llvm-16.0.0-cross-hexagon-unknown-linux-musl/
export PATH=${TOOLS}/x86_64-linux-gnu/bin/:$PATH
export QEMU_LD_PREFIX=${TOOLS}/x86_64-linux-gnu/target/hexagon-unknown-linux-musl

cmake -GNinja \
   -Bbuild_dbg \
   -DCMAKE_BUILD_TYPE=RelWithDebInfo \
   -DCMAKE_TOOLCHAIN_FILE=hexagon-unknown-linux-musl-clang.cmake \
   -DCMAKE_INSTALL_PREFIX=~/scratch/tmp/whisper \
   -S$PWD
cmake --build ./build_dbg
cmake --build ./build_dbg -- install

echo qemu-hexagon  ./build_dbg/bin/bench -w 1 -t 1
#qemu-hexagon -cpu any,paranoid-commit-state=on ./build_dbg/bin/bench -w 1 -t 1
