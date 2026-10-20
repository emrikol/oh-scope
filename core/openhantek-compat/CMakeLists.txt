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

add_library(GraticuleOpenHantekCompat STATIC ${GRATICULE_OPENHANTEK_SOURCES})
add_library(Graticule::OpenHantekCompat ALIAS GraticuleOpenHantekCompat)

set_target_properties(GraticuleOpenHantekCompat PROPERTIES
    AUTOMOC ON
    AUTORCC ON
    POSITION_INDEPENDENT_CODE ON
)

target_compile_features(GraticuleOpenHantekCompat PUBLIC cxx_std_20)

target_include_directories(GraticuleOpenHantekCompat
    PUBLIC
        "${OPENHANTEK_ROOT}/openhantek/src"
        "${OPENHANTEK_ROOT}/openhantek/src/hantekdso"
        "${OPENHANTEK_ROOT}/openhantek/src/usb"
)

target_link_libraries(GraticuleOpenHantekCompat
    PUBLIC
        Qt6::Core
        Qt6::Gui
    PRIVATE
        Qt6::Widgets
        PkgConfig::LIBUSB
        Threads::Threads
)

target_compile_options(GraticuleOpenHantekCompat PRIVATE
    -Wall
    -Wextra
    -Wpedantic
)

if(GRATICULE_BUILD_TESTS)
    enable_testing()
    add_executable(graticule_openhantek_model_smoke tests/model_spec_smoke.cpp)
    target_link_libraries(graticule_openhantek_model_smoke PRIVATE Graticule::OpenHantekCompat)
    add_test(NAME openhantek_model_spec COMMAND graticule_openhantek_model_smoke)
endif()
