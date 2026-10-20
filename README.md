# Oh Scope

**Open-source oscilloscope software for macOS**  
Compatible with Hantek 6022BE and 6022BL.

Oh Scope is building a modern native interface around the proven acquisition
and device-support code from
[OpenHantek6022](https://github.com/OpenHantek/OpenHantek6022). The macOS app
uses SwiftUI and will use Metal for the waveform display. A portable C++ core
and stable C API keep hardware access and signal processing independent of the
interface.

Oh Scope is an independent community project. It is not affiliated with or
endorsed by Qingdao Hantek Electronic Co., Ltd. Hantek product names are used
only to identify compatible hardware.

## Current status

The first project skeleton contains:

- a SwiftUI macOS application shell;
- OpenHantek6022 pinned as a Git submodule;
- `libOhScopeCore`, a shared library built from an explicit set of upstream
  device, firmware, acquisition, trigger, and model sources;
- a versioned, Qt-free C header for native UI clients;
- a C smoke test that verifies the public ABI and 6022BE/BL capabilities;
- architecture and upstream-update documentation.

The library still uses Qt internally because the selected OpenHantek backend
sources depend on it. No Qt or C++ type crosses the public API. Removing those
internal dependencies can therefore happen without changing UI clients.

Physical acquisition has not been tested with an attached oscilloscope yet.

## Architecture

```text
SwiftUI and AppKit controls       Metal waveform renderer
             \                         /
                  Oh Scope model
                         |
                versioned C API
                         |
                  libOhScopeCore
                         |
          OpenHantek hardware backend
                         |
                       libusb
                         |
                Hantek 6022BE/BL
```

See [Architecture](docs/architecture.md), [Core library](docs/core-library.md),
[Build](docs/build.md), [Android plan](docs/android-app-plan.md), and
[Upstream synchronization](docs/upstream.md).

## Quick start

Clone with the pinned upstream source:

```bash
git clone --recurse-submodules https://github.com/emrikol/oh-scope.git
cd oh-scope
```

Build the SwiftUI shell:

```bash
swift build
swift run OhScope
```

Build and test the core library:

```bash
cmake --preset development
cmake --build --preset development
ctest --preset development
```

The core build currently needs CMake, Ninja, Qt 6, libusb, and a C++20
compiler. It does not require FFTW because spectrum processing is outside the
first extraction target.

## Licensing

Oh Scope is licensed under GPL-3.0-or-later. OpenHantek6022 remains under its
upstream GPL terms; its source and history live in the pinned Git submodule.
See [LICENSE](LICENSE) and [third-party notices](THIRD_PARTY_NOTICES.md).
