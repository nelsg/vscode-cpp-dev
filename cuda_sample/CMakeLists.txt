cmake_minimum_required(VERSION 3.10.0 FATAL_ERROR)

project(cuda_sample CUDA CXX)

# FLAGS

set(CMAKE_CUDA_STANDARD 14)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

set(
  CMAKE_CUDA_FLAGS
  "-gencode arch=compute_61,code=sm_61 -gencode arch=compute_70,code=sm_70 -lineinfo -use_fast_math"
  )

set(CMAKE_CUDA_FLAGS_RELEASE -O2)
set(CMAKE_CUDA_FLAGS_DEBUG -g)

# CUDA SOURCES
file(GLOB CU_SOURCES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ./src/*.c*)
file(GLOB CU_HEADERS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ./include/*.h*)
add_executable(cuda_sample ${CU_SOURCES} ${CU_HEADERS})

target_include_directories(cuda_sample SYSTEM
                           PUBLIC ${CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES})
target_include_directories(cuda_sample
                           PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

if(MSVC)
  set_target_properties(cuda_sample
                        PROPERTIES CUDA_SEPARABLE_COMPILATION
                                   ON
                                   CUDA_RESOLVE_DEVICE_SYMBOLS
                                   ON)
elseif(UNIX AND NOT APPLE)

  set_target_properties(cuda_sample PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
endif()
