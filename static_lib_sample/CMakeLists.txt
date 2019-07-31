project(static_lib_sample CXX)

# Static library, therefore STATIC
file(GLOB hs_sources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ./src/*.c*)
file(GLOB hh_headers RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ./include/*.h*)
add_library(static_lib_sample STATIC ${hs_sources} ${hh_headers})

# Boost
set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED ON)
find_package(Boost 1.65.0.0 REQUIRED)
target_include_directories(static_lib_sample SYSTEM PRIVATE ${Boost_INCLUDE_DIRS})

# PUBLIC: target's dependencies of it's user and itself
target_include_directories(static_lib_sample
                           PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
