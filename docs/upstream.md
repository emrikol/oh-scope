# OpenHantek upstream synchronization

## Source pin

`vendor/OpenHantek6022` is a Git submodule pinned to an reviewed upstream
commit. The initial pin is:

```text
repository: https://github.com/OpenHantek/OpenHantek6022.git
commit:     00a622ab2e18290af7c4290e492dadbec3321fb7
```

The compatibility library uses an explicit source manifest in
`cmake/OpenHantekSources.cmake`. New upstream source files never enter the
library without review.

## Update procedure

1. Fetch the upstream repository inside the submodule.
2. Review the upstream commit range and changelog.
3. Check out the selected exact commit.
4. Review changes to files listed in `OpenHantekSources.cmake`.
5. Configure, build, and run backend smoke tests.
6. Build the original OpenHantek GUI when its full dependencies are available.
7. Record hardware-required checks separately; never infer them from demo mode.
8. Commit the submodule pointer and any deliberate compatibility changes in one
   update.

## Change policy

Prefer adapters and new files outside the submodule. When an upstream source
change is unavoidable, make it in a thin core fork as a focused commit and keep
the official OpenHantek repository configured as its `upstream` remote. Avoid
source snapshots, broad formatting changes, and directory reorganizations.

Generally useful changes, such as a backend library target or separation of
acquisition settings from view settings, should be proposed upstream. The C
bridge and native application remain Graticule-specific.
