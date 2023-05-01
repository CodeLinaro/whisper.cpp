
set(CMAKE_C_COMPILER hexagon-unknown-linux-musl-clang)
set(CMAKE_CXX_COMPILER hexagon-unknown-linux-musl-clang++)
set(CMAKE_C_FLAGS "-mv67 -O3 -mhvx")
set(CMAKE_CXX_FLAGS "-mv67 -O3 -mhvx")
set(CMAKE_SYSTEM_PROCESSOR "hexagon")
set(CMAKE_CROSSCOMPILING_EMULATOR qemu-hexagon)

