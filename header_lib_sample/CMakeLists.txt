project(header_lib_sample CXX)

# Header only library, therefore INTERFACE
add_library(header_lib_sample INTERFACE)

# Boost
set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED ON)
find_package(Boost 1.65.0.0 REQUIRED)
target_include_directories(header_lib_sample SYSTEM
                           INTERFACE ${Boost_INCLUDE_DIRS})

# INTERFACE targets only have INTERFACE properties
target_include_directories(header_lib_sample
                           INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include)
