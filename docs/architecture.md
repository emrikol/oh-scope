# Oh Scope architecture

## Direction

Oh Scope uses native interfaces on each platform and shares hardware,
acquisition, and portable signal-processing code through a C++ core. SwiftUI,
AppKit, and Metal form the macOS application. Android can use the same core
through JNI while retaining a Jetpack Compose interface.

## Layers

### Native application

The native application owns windows, commands, settings presentation,
accessibility, documents, and platform lifecycle. Large sample buffers must not
be published as ordinary SwiftUI observable state.

### Renderer

The macOS waveform renderer will use MetalKit. It consumes immutable capture
frames through a bounded latest-frame queue and renders min/max envelopes at
the drawable's physical pixel resolution.

### Stable bridge

The bridge exposes a versioned C ABI from `libOhScopeCore`. Its first revision
provides build provenance and supported-model capabilities. Acquisition will
add opaque handles, value settings, immutable frames, and explicit ownership.
Qt and C++ standard-library types must not cross this boundary.

### Portable core

The core owns device discovery, firmware upload, USB transfers, acquisition,
calibration, trigger detection, measurements, and portable DSP. It initially
uses selected OpenHantek sources through the compatibility target.

## Extraction stages

1. Build selected upstream sources without the upstream GUI.
2. Add a backend smoke harness and stable C bridge.
3. Replace UI-coupled settings with acquisition-only values.
4. Replace Qt timers, threads, locks, settings, and signals inside the core.
5. Separate calibrated samples and measurements from render geometry.
6. Connect the Swift session model and Metal renderer.

The original OpenHantek application remains buildable throughout extraction so
that upstream behavior can continue to exercise the same device logic.
