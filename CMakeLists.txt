cmake_minimum_required(VERSION 3.16)

# C compiler
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED TRUE)
set(CMAKE_C_EXTENSIONS ON)

# C++ compiler
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
set(CMAKE_CXX_EXTENSIONS ON)

# Both developer and user mode
set(ENABLE_CACHE_DEFAULT ON)
set(ENABLE_CONAN_DEFAULT OFF)

# Developer mode
option(ENABLE_DEVELOPER_MODE "Enable 'developer mode'" TRUE)
set(ENABLE_COVERAGE_DEVELOPER_DEFAULT ON)

# Sanitizers
set(ENABLE_SANITIZER_LEAK_DEVELOPER_DEFAULT ON)
set(ENABLE_SANITIZER_MEMORY_DEVELOPER_DEFAULT ON)
set(ENABLE_SANITIZER_THREAD_DEVELOPER_DEFAULT OFF)

include(FetchContent)

FetchContent_Declare(
    _project_options 
    URL https://github.com/aminya/project_options/archive/refs/tags/v0.26.2.zip
    DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)
FetchContent_GetProperties(_project_options)
if(NOT _project_options_POPULATED)
    FetchContent_Populate(_project_options)
endif()
include(${_project_options_SOURCE_DIR}/Index.cmake)

project(
    main 
    VERSION 1.0.0
    DESCRIPTION "A main project for c++."
    LANGUAGES C CXX
)

include(${_project_options_SOURCE_DIR}/src/Common.cmake)
common_project_options()

include(${_project_options_SOURCE_DIR}/src/DynamicProjectOptions.cmake)
dynamic_project_options(
    CPPCHECK_OPTIONS
    --project=${CMAKE_BINARY_DIR}/compile_commands.json
)

target_compile_features(project_options INTERFACE cxx_std_${CMAKE_CXX_STANDARD})

set(CONAN_CMAKE_SILENT_OUTPUT TRUE)
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/build/conan)

# Adding the src:
include_directories(src)
add_subdirectory(src)

# Adding the tests:
option(ENABLE_TESTING "Enable the tests" ON)
if(ENABLE_TESTING)
    enable_testing()
    message(STATUS "Building Tests.")
    add_subdirectory(tests)
endif()

option(ENABLE_FUZZING "Enable the fuzz tests" OFF)
if(ENABLE_FUZZING)
    message(STATUS "Building Fuzz Tests, using fuzzing sanitizer https://www.llvm.org/docs/LibFuzzer.html")
    add_subdirectory(fuzz_tests)
endif()
