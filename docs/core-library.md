# Oh Scope core library

`libOhScopeCore` is the hardware and signal-processing boundary shared by the
native applications. It currently packages the selected OpenHantek6022 backend
sources into one shared library and presents a small C ABI in
`core/oh-scope-core/include/ohscope/core.h`.

## Why a C ABI

Swift and Kotlin/JNI can both consume C-compatible declarations without
exposing the Qt object model, C++ templates, exceptions, or ownership rules.
The public structures use fixed-width values and fixed-capacity strings. Future
stateful APIs will use opaque handles with explicit create and destroy calls.

The ABI version starts at `1`. Additive functions do not require a version
change. Changing the layout or meaning of an existing public type does.

## Current API

The first API provides:

- the Oh Scope core ABI version;
- the exact pinned OpenHantek6022 Git revision compiled into the library;
- a deterministic catalog of the supported 6022BE and 6022BL models;
- runtime and bootloader USB identities;
- channel counts and maximum single-channel and multi-channel sample rates.

The model API is intentionally hardware-independent, so its test runs without a
scope attached. It validates that the expected upstream model definitions are
present in the library.

## Next API milestone

The next revision should introduce an opaque session handle and the smallest
complete acquisition path:

1. enumerate compatible USB devices;
2. open one device and upload firmware when required;
3. report re-enumeration and connection state;
4. apply an immutable acquisition configuration;
5. start and stop transfers;
6. deliver timestamped sample blocks through a bounded queue;
7. expose errors and dropped-sample counts as values rather than callbacks into
   UI code.

Callbacks must never execute on the main UI thread implicitly. Buffers need an
explicit lifetime contract before Swift or JNI integration begins.

## Upstream boundary

The source list in `cmake/OpenHantekSources.cmake` is explicit. Updating the
submodule cannot silently add new code to the library. The root CMake configure
step also compares the checked-out submodule revision with
`dependencies/openhantek.lock.json` and fails when they differ.
