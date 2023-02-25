# Version settings
cmake_minimum_required(VERSION 3.15.3...3.20)

if (${CMAKE_VERSION} VERSION_LESS 3.12)
	cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
endif()

# Verbose messages
set(CMAKE_VERBOSE_MAKEFILE OFF)

# Set tool chain configs
set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/arm-none-eabi-gcc.cmake")

#
# Project settings / Add the project name, version, description
# Also remember to edit the file in docs/Doxyfile.in and change
# the properties PROJECT_NAME, PROJECT_NUMBER, PROJECT_BRIEF
#
project(
	kl05z-sample-project VERSION 1.0
	DESCRIPTION "kl05z-sample-project"
	LANGUAGES ASM C CXX
)

# If doxygen is installed so generates the documentation
find_package(Doxygen)
if (DOXYGEN_FOUND)
	# Docs input and output
	set(DOXYGEN_IN "${CMAKE_CURRENT_SOURCE_DIR}/docs/Doxyfile.in")
	set(DOXYGEN_OUT "${CMAKE_CURRENT_BINARY_DIR}/Doxyfile")

	# Configure the output documentation file
	configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)
	message("Doxygen build started")

	# Generates the doc
	add_custom_target(
		documentation ALL
		COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
		COMMENT "Generating documentation with Doxygen"
		VERBATIM
	)
else (DOXYGEN_FOUND)
	message("Skipping documentation generation, to generate documentation doxygen needs to be instaled")
endif (DOXYGEN_FOUND)

# Source Dir variable
set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}")

# Translations units of the project
set(
	TRANSLATION_FILES
	# Device
	"${SRC_DIR}/device/system_MKL05Z4.c"
	"${SRC_DIR}/device/startup/startup_MKL05Z4.S"
	#
	# Source / Add your .c, .cpp, .S files here
	#
	"${SRC_DIR}/source/main.c"
)

# Header files of the project
set(
	HEADERS_FILES
	# CMSIS
	"${SRC_DIR}/CMSIS/core_cmFunc.h"
	"${SRC_DIR}/CMSIS/core_cmInstr.h"
	"${SRC_DIR}/CMSIS/core_cm0plus.h"
	# Device
	"${SRC_DIR}/device/MKL05Z4.h"
	"${SRC_DIR}/device/system_MKL05Z4.h"
	#
	# Source / Add your header files here
	#
)

# Executable settings
set(EXECUTABLE_FILE "${PROJECT_NAME}.elf")
set(LINKER_FILE "${CMAKE_SOURCE_DIR}/device/linker/MKL05Z32xxx4_flash.ld")

# Build the executable based on the source files
add_executable(${EXECUTABLE_FILE} ${HEADERS_FILES} ${TRANSLATION_FILES})

# Configure default include directories
set(
	DEFAULT_INCLUDE_DIRECTORIES
	"${SRC_DIR}/source" "${SRC_DIR}/CMSIS" "${SRC_DIR}/device"
)
target_include_directories(${EXECUTABLE_FILE} PRIVATE ${DEFAULT_INCLUDE_DIRECTORIES})

# Configure project language settings
set_property(TARGET ${EXECUTABLE_FILE} PROPERTY CXX_STANDARD 17)
set_property(TARGET ${EXECUTABLE_FILE} PROPERTY C_STANDARD 99)
set_property(TARGET ${EXECUTABLE_FILE} PROPERTY C_STANDARD_REQUIRED ON)
set_property(TARGET ${EXECUTABLE_FILE} PROPERTY C_EXTENSIONS OFF)

# Compiler options
target_compile_options(
	${EXECUTABLE_FILE} PRIVATE
	-mcpu=cortex-m0plus
	-mthumb
	-fmessage-length=0
	-fsigned-char
	-fdata-sections
	-ffunction-sections
	-Wall
	-O0
	-g3
)

# Linker options
target_link_options(
	${EXECUTABLE_FILE} PRIVATE
	-T${LINKER_FILE}
	-mcpu=cortex-m0plus
	-mthumb
	-specs=nano.specs
	-specs=nosys.specs
	-Wl,-Map=${PROJECT_NAME}.map,--cref
	-Wl,--gc-sections
	-Xlinker
	-print-memory-usage
	-lc
	-lm
	-lnosys
)

# After finishing the build print the executable size
add_custom_command(
	TARGET ${EXECUTABLE_FILE}
	POST_BUILD
	${CMAKE_SIZE_UTIL} ${EXECUTABLE_FILE}
)

# After finishing the build creates hex and bin file
add_custom_command(
	TARGET ${EXECUTABLE_FILE}
	POST_BUILD
	COMMAND ${CMAKE_OBJCOPY} -O ihex ${EXECUTABLE_FILE} ${PROJECT_NAME}.hex
	COMMAND ${CMAKE_OBJCOPY} -O binary ${EXECUTABLE_FILE} ${PROJECT_NAME}.bin
)
