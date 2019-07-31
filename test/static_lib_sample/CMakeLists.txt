cmake_minimum_required(VERSION 3.10.0 FATAL_ERROR)

project(static_lib_sample_test CXX)

# the test program
add_executable(static_lib_sample_test test.cpp)
target_link_libraries(static_lib_sample_test
                      PRIVATE static_lib_sample GTest::GTest GTest::Main)

# add google test
gtest_add_tests(TARGET static_lib_sample_test)
