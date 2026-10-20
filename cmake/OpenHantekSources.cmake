# Explicit source manifest for the pinned OpenHantek compatibility target.
#
# Do not replace this list with a glob. An upstream update must make source-list
# changes visible during review.

set(OH_SCOPE_OPENHANTEK_SOURCES
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekprotocol/controlcommand.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekprotocol/controlStructs.cpp

    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/usb/ezusb.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/usb/finddevices.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/usb/scopedevice.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/usb/uploadFirmware.cpp

    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso/capturing.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso/controlsettings.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso/controlspecification.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso/dsomodel.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso/enums.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso/hantekdsocontrol.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso/mathchannel.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso/mathmodes.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso/modelregistry.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso/triggering.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso/models/modelDEMO.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/hantekdso/models/modelDSO6022.cpp

    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/src/utils/printutils.cpp
    ${OH_SCOPE_OPENHANTEK_ROOT}/openhantek/res/firmwares.qrc
)
