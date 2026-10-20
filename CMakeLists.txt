cmake_minimum_required(VERSION 3.28)

project(OpenHantekStudio VERSION 0.1.0 LANGUAGES C CXX)

option(OPENHANTEK_STUDIO_BUILD_CORE_COMPAT "Build the pinned OpenHantek compatibility library" ON)
option(OPENHANTEK_STUDIO_BUILD_TESTS "Build backend smoke tests" ON)

if(OPENHANTEK_STUDIO_BUILD_TESTS)
    enable_testing()
endif()

if(OPENHANTEK_STUDIO_BUILD_CORE_COMPAT)
    add_subdirectory(core/openhantek-compat)
endif()
