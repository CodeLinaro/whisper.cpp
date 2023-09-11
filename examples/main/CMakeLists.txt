set(TARGET main)
add_executable(${TARGET} main.cpp)
install(TARGETS ${TARGET})

include(DefaultTargetOptions)

target_link_libraries(${TARGET} PRIVATE common whisper ${CMAKE_THREAD_LIBS_INIT})
