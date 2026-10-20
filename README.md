# OpenHantek Studio

OpenHantek Studio is a modern, open-source oscilloscope application built
around a native Swift interface and a portable hardware and signal-processing
core. The first supported instrument is the Hantek 6022BE.

The name describes the project's foundation and purpose directly: a modern
instrument workspace built from the OpenHantek acquisition code. OpenHantek
Studio is an independent community project and is not affiliated with Hantek.

## Current status

The project is in its initial extraction phase:

- OpenHantek6022 is pinned as a Git submodule.
- `OpenHantekCoreCompat` builds selected acquisition sources as a static
  library while leaving the upstream GUI untouched.
- A small SwiftUI application establishes the native macOS application shell.
- The stable C bridge and Metal waveform renderer are the next milestones.

No physical-hardware behavior has been validated yet.

## Architecture

```text
SwiftUI and AppKit controls       Metal waveform renderer
             \                         /
            OpenHantek Swift model
                       |
                 stable C bridge
                       |
         hardware and processing core
                       |
                    libusb
                       |
                 Hantek 6022BE
```

The compatibility target initially retains Qt internally to minimize changes
to OpenHantek. Qt types will not cross the bridge into Swift. The backend can
therefore be refactored away from Qt without changing the application API.

See [Architecture](docs/architecture.md), [Build](docs/build.md), and
[Upstream synchronization](docs/upstream.md).

## Quick start

Initialize the pinned upstream source after cloning:

```bash
git submodule update --init --recursive
```

Build the SwiftUI shell:

```bash
swift build
```

Build the OpenHantek compatibility library:

```bash
cmake --preset development
cmake --build --preset development
ctest --preset development
```

The compatibility build currently needs CMake, Ninja, Qt 6, libusb, and a C++20
compiler. It does not require FFTW because spectrum processing is not in the
first extraction target.

## Licensing

OpenHantek6022 source files are licensed under GPL-2.0-or-later. Linking that
code into a distributed OpenHantek Studio application requires GPL-compatible release
terms and corresponding source. The project license will be finalized before
the first distributable application build.
