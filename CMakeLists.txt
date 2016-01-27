# Serge Voilokov, 2016
# cmake file for building webcam tools.
#
#
# Generate makefile:
# ./gen-cmake.sh

cmake_minimum_required(VERSION 2.6)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

#include(../common/macros.cmake)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(..)

#gen_version_c()

add_executable(
	create-movie
	create-movie.c
)
