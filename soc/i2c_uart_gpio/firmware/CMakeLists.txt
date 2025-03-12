
cmake_minimum_required(VERSION 3.15...3.31)

include(../../../tools/riscv.cmake)
set(MAKEHEX ${CMAKE_CURRENT_SOURCE_DIR}/../../../tools/makehex.py)


project(i2c_uart_gpio VERSION 1.0 LANGUAGES C ASM)

set(TARGET ${PROJECT_NAME})

add_executable(${TARGET}.elf start.S main.c)


target_include_directories(${TARGET}.elf PRIVATE 
    ../ip/uart/generated/sw 
    ../ip/gpio/generated/sw 
    ../ip/i2c/generated/sw 
    )

SET(LINKER_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/sections.lds")
SET(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} -T ${LINKER_SCRIPT} -Wl,--build-id=none,-Bstatic,--strip-debug,-lgcc,-Map=${TARGET}.map")


add_custom_command(
    TARGET ${TARGET}.elf
    POST_BUILD
    COMMAND ${CMAKE_OBJDUMP} -S  ${TARGET}.elf > ${TARGET}.disasm
)
               
add_custom_command(
    TARGET ${TARGET}.elf
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary  ${TARGET}.elf ${TARGET}.bin
)

add_custom_command(
    TARGET ${TARGET}.elf
    POST_BUILD
#     #COMMAND ${CMAKE_OBJCOPY} -O ihex  ${TARGET}.elf ${TARGET}.hex
    COMMAND ${MAKEHEX} ${TARGET}.bin 1024 > ${TARGET}.hex
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)