# Build

## Recorded development host

- Apple Silicon (`arm64`)
- macOS 27.0.1
- Xcode 27.1
- Swift 6.4
- CMake 4.4.3
- Ninja 1.13.2
- Qt 6.11.1
- libusb 1.0.30

These versions document the first working environment. Release inputs will be
locked separately before producing distributable artifacts.

## Fetch upstream source

```bash
git submodule update --init --recursive
```

The submodule commit is the source lock. Builds must never fetch an unpinned
OpenHantek branch implicitly.

## SwiftUI shell

```bash
swift build
swift run OhScope
```

Swift Package Manager currently builds a development executable. A signed app
bundle and Xcode project will be added when the bridge is ready to embed.

## Core library

Required development packages are CMake, Ninja, Qt 6, and libusb.

```bash
cmake --preset development
cmake --build --preset development
ctest --preset development
```

The build produces `libOhScopeCore` and a plain-C API test. The first core
target intentionally excludes OpenHantek's spectrum generator and FFTW
dependency. Spectrum processing will be introduced behind a portable
processing interface.

## Reproducible releases

Release builds will pin dependency source revisions and checksums, record the
Xcode and SDK versions, set `SOURCE_DATE_EPOCH` from the source revision, and
remove machine-specific paths from compiler output. Developer ID signatures
and notarization tickets contain external timestamps and are therefore outside
the byte-reproducible unsigned build.
