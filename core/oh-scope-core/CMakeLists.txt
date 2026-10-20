find_package(Qt6 6.2 REQUIRED COMPONENTS Core Gui Widgets)
find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBUSB REQUIRED IMPORTED_TARGET libusb-1.0)
find_package(Threads REQUIRED)

include("${PROJECT_SOURCE_DIR}/cmake/OpenHantekSources.cmake")

add_library(OhScopeCore SHARED
    src/core.cpp
    ${OH_SCOPE_OPENHANTEK_SOURCES}
)
add_library(OhScope::Core ALIAS OhScopeCore)

set_target_properties(OhScopeCore PROPERTIES
    AUTOMOC ON
    AUTORCC ON
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    OUTPUT_NAME OhScopeCore
    VERSION "${PROJECT_VERSION}"
    SOVERSION 0
)

target_compile_features(OhScopeCore PUBLIC cxx_std_20)

target_compile_definitions(OhScopeCore PRIVATE
    OH_SCOPE_CORE_BUILD=1
    OH_SCOPE_LOCKED_COMPATIBILITY_API=${OH_SCOPE_COMPATIBILITY_API}
    OH_SCOPE_OPENHANTEK_REVISION="${OH_SCOPE_OPENHANTEK_REVISION}"
)

target_include_directories(OhScopeCore
    PUBLIC
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
        "$<INSTALL_INTERFACE:include>"
    PRIVATE
        "${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src"
        "${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso"
        "${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/usb"
)

target_link_libraries(OhScopeCore
    PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Widgets
        PkgConfig::LIBUSB
        Threads::Threads
)

target_compile_options(OhScopeCore PRIVATE
    -Wall
    -Wextra
    -Wpedantic
)

if(OH_SCOPE_BUILD_TESTS)
    add_executable(oh_scope_core_api_tests tests/core_api_tests.c)
    target_link_libraries(oh_scope_core_api_tests PRIVATE OhScope::Core)
    add_test(NAME oh_scope_core_api COMMAND oh_scope_core_api_tests)
endif()

include(GNUInstallDirs)
install(
    TARGETS OhScopeCore
    EXPORT OhScopeCoreTargets
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
)
install(
    DIRECTORY include/
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)
install(
    EXPORT OhScopeCoreTargets
    FILE OhScopeCoreTargets.cmake
    NAMESPACE OhScope::
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/OhScopeCore"
)
