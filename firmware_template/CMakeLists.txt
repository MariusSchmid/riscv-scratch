
cmake_minimum_required(VERSION 3.15...3.31)

include(../tools/riscv.cmake)


project(example VERSION 1.0 LANGUAGES C ASM)

set(TARGET ${PROJECT_NAME}.elf)
add_executable(${TARGET} start.S main.c)

SET(LINKER_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/sections.lds")
SET(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} -T ${LINKER_SCRIPT} -Wl,--build-id=none,-Bstatic,--strip-debug,-lgcc,-Map=${TARGET}.map")


add_custom_command(
    TARGET ${TARGET}
    POST_BUILD
    COMMAND ${CMAKE_OBJDUMP} -S  ${TARGET} > ${TARGET}.disasm
)
        
add_custom_command(
    TARGET ${TARGET}
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex  ${TARGET} ${TARGET}.hex
)
