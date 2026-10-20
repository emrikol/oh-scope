cmake_minimum_required(VERSION 3.28)

project(Graticule VERSION 0.1.0 LANGUAGES C CXX)

option(GRATICULE_BUILD_OPENHANTEK_COMPAT "Build the pinned OpenHantek compatibility library" ON)
option(GRATICULE_BUILD_TESTS "Build backend smoke tests" ON)

if(GRATICULE_BUILD_TESTS)
    enable_testing()
endif()

if(GRATICULE_BUILD_OPENHANTEK_COMPAT)
    add_subdirectory(core/openhantek-compat)
endif()
