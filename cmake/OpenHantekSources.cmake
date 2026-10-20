# Explicit source manifest for the pinned OpenHantek compatibility target.
#
# Do not replace this list with a glob. An upstream update must make source-list
# changes visible during review.

set(OPENHANTEK_STUDIO_UPSTREAM_SOURCES
    ${OPENHANTEK_ROOT}/openhantek/src/hantekprotocol/controlcommand.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/hantekprotocol/controlStructs.cpp

    ${OPENHANTEK_ROOT}/openhantek/src/usb/ezusb.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/usb/finddevices.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/usb/scopedevice.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/usb/uploadFirmware.cpp

    ${OPENHANTEK_ROOT}/openhantek/src/hantekdso/capturing.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/hantekdso/controlsettings.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/hantekdso/controlspecification.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/hantekdso/dsomodel.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/hantekdso/enums.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/hantekdso/hantekdsocontrol.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/hantekdso/mathchannel.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/hantekdso/mathmodes.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/hantekdso/modelregistry.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/hantekdso/triggering.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/hantekdso/models/modelDEMO.cpp
    ${OPENHANTEK_ROOT}/openhantek/src/hantekdso/models/modelDSO6022.cpp

    ${OPENHANTEK_ROOT}/openhantek/src/utils/printutils.cpp
    ${OPENHANTEK_ROOT}/openhantek/res/firmwares.qrc
)
