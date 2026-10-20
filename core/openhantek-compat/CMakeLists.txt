find_package(Qt6 6.2 REQUIRED COMPONENTS Core Gui Widgets)
find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBUSB REQUIRED IMPORTED_TARGET libusb-1.0)
find_package(Threads REQUIRED)

set(OPENHANTEK_ROOT "${PROJECT_SOURCE_DIR}/vendor/OpenHantek6022")

if(NOT EXISTS "${OPENHANTEK_ROOT}/openhantek/src/hantekdso/hantekdsocontrol.cpp")
    message(FATAL_ERROR
        "Pinned OpenHantek source is missing. Run: git submodule update --init --recursive"
    )
endif()

include("${PROJECT_SOURCE_DIR}/cmake/OpenHantekSources.cmake")

add_library(OpenHantekCoreCompat STATIC ${OPENHANTEK_STUDIO_UPSTREAM_SOURCES})
add_library(OpenHantekStudio::CoreCompat ALIAS OpenHantekCoreCompat)

set_target_properties(OpenHantekCoreCompat PROPERTIES
    AUTOMOC ON
    AUTORCC ON
    POSITION_INDEPENDENT_CODE ON
)

target_compile_features(OpenHantekCoreCompat PUBLIC cxx_std_20)

target_include_directories(OpenHantekCoreCompat
    PUBLIC
        "${OPENHANTEK_ROOT}/openhantek/src"
        "${OPENHANTEK_ROOT}/openhantek/src/hantekdso"
        "${OPENHANTEK_ROOT}/openhantek/src/usb"
)

target_link_libraries(OpenHantekCoreCompat
    PUBLIC
        Qt6::Core
        Qt6::Gui
    PRIVATE
        Qt6::Widgets
        PkgConfig::LIBUSB
        Threads::Threads
)

target_compile_options(OpenHantekCoreCompat PRIVATE
    -Wall
    -Wextra
    -Wpedantic
)

if(OPENHANTEK_STUDIO_BUILD_TESTS)
    enable_testing()
    add_executable(openhantek_model_smoke tests/model_spec_smoke.cpp)
    target_link_libraries(openhantek_model_smoke PRIVATE OpenHantekStudio::CoreCompat)
    add_test(NAME openhantek_model_spec COMMAND openhantek_model_smoke)
endif()
