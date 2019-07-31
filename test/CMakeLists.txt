cmake_minimum_required(VERSION 3.10.0 FATAL_ERROR)

# GTest
find_package(GTest REQUIRED)
include_directories(SYSTEM ${GTEST_INCLUDE_DIRS})

# SUBDIRECTORIES
add_subdirectory(header_lib_sample)
add_subdirectory(static_lib_sample)
