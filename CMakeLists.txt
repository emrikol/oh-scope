cmake_minimum_required(VERSION 3.28)

project(OhScope VERSION 0.1.0 LANGUAGES C CXX)

option(OH_SCOPE_BUILD_CORE "Build the Oh Scope core library" ON)
option(OH_SCOPE_BUILD_TESTS "Build core library tests" ON)

set(OH_SCOPE_OPENHANTEK_ROOT "${PROJECT_SOURCE_DIR}/vendor/OpenHantek6022")
set(OH_SCOPE_OPENHANTEK_LOCK "${PROJECT_SOURCE_DIR}/dependencies/openhantek.lock.json")

file(READ "${OH_SCOPE_OPENHANTEK_LOCK}" OH_SCOPE_OPENHANTEK_LOCK_JSON)
string(JSON OH_SCOPE_OPENHANTEK_REVISION GET "${OH_SCOPE_OPENHANTEK_LOCK_JSON}" commit)
string(JSON OH_SCOPE_COMPATIBILITY_API GET "${OH_SCOPE_OPENHANTEK_LOCK_JSON}" compatibilityApi)

if(NOT EXISTS "${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso/hantekdsocontrol.cpp")
    message(FATAL_ERROR
        "Pinned OpenHantek source is missing. Run: git submodule update --init --recursive"
    )
endif()

find_package(Git QUIET)
if(Git_FOUND AND EXISTS "${OH_SCOPE_OPENHANTEK_ROOT}/.git")
    execute_process(
        COMMAND "${GIT_EXECUTABLE}" rev-parse HEAD
        WORKING_DIRECTORY "${OH_SCOPE_OPENHANTEK_ROOT}"
        RESULT_VARIABLE OH_SCOPE_GIT_RESULT
        OUTPUT_VARIABLE OH_SCOPE_OPENHANTEK_ACTUAL_REVISION
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET
    )
    if(OH_SCOPE_GIT_RESULT EQUAL 0 AND
       NOT OH_SCOPE_OPENHANTEK_ACTUAL_REVISION STREQUAL OH_SCOPE_OPENHANTEK_REVISION)
        message(FATAL_ERROR
            "OpenHantek6022 is at ${OH_SCOPE_OPENHANTEK_ACTUAL_REVISION}; "
            "the source lock requires ${OH_SCOPE_OPENHANTEK_REVISION}"
        )
    endif()
endif()

if(OH_SCOPE_BUILD_TESTS)
    enable_testing()
endif()

if(OH_SCOPE_BUILD_CORE)
    add_subdirectory(core/oh-scope-core)
endif()
