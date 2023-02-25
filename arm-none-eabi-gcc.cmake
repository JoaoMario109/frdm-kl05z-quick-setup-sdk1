set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

#
# Remember to change this path to you toolchain dir
#
set(ARM_TOOLCHAIN_DIR "/usr/bin")

# Creates the tool prefix
set(TOOL_PREFIX "${ARM_TOOLCHAIN_DIR}/arm-none-eabi-")

# Sets compilers paths
if (WIN32)
	set(CMAKE_C_COMPILER "${TOOL_PREFIX}gcc.exe")
	set(CMAKE_CXX_COMPILER "${TOOL_PREFIX}g++.exe")
elseif (UNIX)
	set(CMAKE_C_COMPILER "${TOOL_PREFIX}gcc")
	set(CMAKE_CXX_COMPILER "${TOOL_PREFIX}g++")
endif()

set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})

# Copy and size tool
set(CMAKE_OBJCOPY "${TOOL_PREFIX}objcopy" CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE_UTIL "${TOOL_PREFIX}size" CACHE INTERNAL "size tool")

# Cross compiling options
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_FIND_ROOT_PATH ${ARM_TOOLCHAIN_DIR})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
