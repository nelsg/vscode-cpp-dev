cmake_minimum_required(VERSION 3.10.0 FATAL_ERROR)

project(cmake_sample_main CXX)

# main program
add_executable(cmake_sample_main main.cpp)
target_link_libraries(cmake_sample_main
                      PRIVATE header_lib_sample static_lib_sample)
