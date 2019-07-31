cmake_minimum_required(VERSION 3.10.0 FATAL_ERROR)

#
# STATIC VARIABLES
#

# Define Release by default.
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
  message(STATUS "CMAKE_BUILD_TYPE not specified: Use Release by default.")
endif(NOT CMAKE_BUILD_TYPE)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON) # EXPORT COMPILE COMMANDS

#
# OUTPUTS
#

set(OUTPUT_DEBUG Debug/bin)
set(OUTPUT_RELEASE Release/bin)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/${OUTPUT_DEBUG}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/${OUTPUT_DEBUG}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/${OUTPUT_DEBUG}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE
    "${CMAKE_BINARY_DIR}/${OUTPUT_RELEASE}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE
    "${CMAKE_BINARY_DIR}/${OUTPUT_RELEASE}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE
    "${CMAKE_BINARY_DIR}/${OUTPUT_RELEASE}")

#
# COMPILER/LINKER FLAGS
#

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(NOT CMAKE_BUILD_TYPE STREQUAL "Debug")
  add_definitions(-DNDEBUG)
endif()

if(MSVC)
  set(CMAKE_MSVC_PARALLEL_ENABLE ON)
  set(
    CMAKE_CXX_FLAGS
    "/D \"_CONSOLE\" /D \"UNICODE\" /D \"_UNICODE\" /source-charset:utf-8 /permissive- /MP /GS /Zc:rvalueCast /W3 /Zc:wchar_t /sdl /Zc:inline /fp:precise /errorReport:prompt /WX- /Zc:forScope /Gd /FC /EHsc /diagnostics:classic"
    )
  set(CMAKE_CXX_FLAGS_DEBUG "/D\"_DEBUG\" /JMC /ZI /Od /RTC1 /MTd /FAcs")
  set(CMAKE_CXX_FLAGS_RELEASE "/GL /Gy /Zi /Gm- /O2 /Oi /MT")

  set(CMAKE_EXE_LINKER_FLAGS
      "/NXCOMPAT /DYNAMICBASE /DEBUG /ERRORREPORT:PROMPT")
  set(CMAKE_EXE_LINKER_FLAGS_DEBUG "/INCREMENTAL")
  set(CMAKE_EXE_LINKER_FLAGS_RELEASE
      "/LTCG:incremental /INCREMENTAL:NO /OPT:REF /OPT:ICF")
elseif(UNIX AND NOT APPLE)
  if(NOT EXISTS ${CMAKE_CXX_COMPILER})
    set(CMAKE_CXX_COMPILER "clang++")
    message(
      STATUS "CMAKE_CXX_COMPILER is not specified: Use clang++ by default.")
  endif()
  set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g3")
  set(CMAKE_CXX_FLAGS_RELEASE "-O2")
  # set(CMAKE_CXX_FLAGS_RELEASE "-O2 -march=native")
  set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wno-unknown-pragmas -Wconversion")
  if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fdiagnostics-color=always")
  elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fcolor-diagnostics")
  endif()
endif()

#
# TIDY
#

option(CLANG_TIDY "Perform ClangTidy" OFF)
option(CLANG_TIDY_FIX "Perform fixes for ClangTidy" OFF)

if(CLANG_TIDY)
  # Add clang-tidy if available
  find_program(CLANG_TIDY_EXE
               NAMES "clang-tidy"
               DOC "Path to clang-tidy executable")
  if(CLANG_TIDY_EXE)
    if(CLANG_TIDY_FIX)
      set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_EXE}" "-fix")
    else()
      set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_EXE}")
    endif()
  endif()
else()
  unset(CLANG_TIDY_EXE CACHE)
  unset(CMAKE_CXX_CLANG_TIDY CACHE)
endif()

#
# PROJECT
#

project(cmake_sample_all CXX)

#
# SUBDIRECTORIES
#

# header only library project
add_subdirectory(header_lib_sample)

# static library project
add_subdirectory(static_lib_sample)

# CUDA project (uncomment to enable CUDA build)
add_subdirectory(cuda_sample)

# main project
add_subdirectory(src)

#
# CTest
#

enable_testing()
add_subdirectory(test)
