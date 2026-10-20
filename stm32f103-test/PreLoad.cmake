# PreLoad.cmake
# CMake 会在读取顶层 CMakeLists.txt 之前自动加载本文件。
# 作用：把 STM32Cube 扩展自带的 GNU 工具链目录补充到 PATH，
#       使 configure 阶段能找到 arm-none-eabi-gcc。
# 本文件由用户维护，STM32CubeMX 重新生成代码时不会覆盖它。

set(_stm32_bundles_root "$ENV{LOCALAPPDATA}/STM32Cube/bundles")
file(TO_CMAKE_PATH "${_stm32_bundles_root}" _stm32_bundles_root)

find_program(STM32_PRELOAD_ARM_GCC arm-none-eabi-gcc NO_CACHE)

if(NOT STM32_PRELOAD_ARM_GCC AND EXISTS "${_stm32_bundles_root}")
    file(GLOB _stm32_gcc_candidates
        "${_stm32_bundles_root}/gnu-tools-for-stm32/*/bin/arm-none-eabi-gcc.exe")
    if(_stm32_gcc_candidates)
        list(GET _stm32_gcc_candidates 0 _stm32_gcc_exe)
        get_filename_component(_stm32_gcc_bin "${_stm32_gcc_exe}" DIRECTORY)
        file(TO_CMAKE_PATH "${_stm32_gcc_bin}" _stm32_gcc_bin)
        set(ENV{PATH} "${_stm32_gcc_bin};$ENV{PATH}")
        set(STM32_PRELOAD_ARM_GCC "${_stm32_gcc_exe}")
        message(STATUS "PreLoad: arm-none-eabi-gcc not in PATH, prepended ${_stm32_gcc_bin}")
    endif()
endif()

if(NOT STM32_PRELOAD_ARM_GCC)
    message(WARNING "PreLoad: arm-none-eabi-gcc not found. Install the GNU tools bundle or add it to PATH.")
endif()

unset(STM32_PRELOAD_ARM_GCC)
unset(_stm32_bundles_root)
unset(_stm32_gcc_candidates)
unset(_stm32_gcc_exe)
unset(_stm32_gcc_bin)
