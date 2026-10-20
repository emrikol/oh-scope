# Hantek 6022BE Workbench

## Purpose

This directory is the working area for a Hantek 6022BE USB oscilloscope. Use it for setup notes, repeatable capture scripts, measurements, exported traces, plots, and small utilities related to the instrument.

Keep the workspace useful as a lab notebook: a future reader should be able to tell how the scope was connected, how data was acquired, and how a result was produced.

## Start Every Task by Checking

1. Read this file and any task-specific notes under `docs/`.
2. Inspect the existing files and working-tree state before changing anything.
3. Detect the host OS, connected USB device, and installed scope software rather than assuming them.
4. Confirm the probe attenuation and channel settings before interpreting voltages.

Do not initialize a repository, install software or drivers, change USB permissions, or replace a working acquisition setup unless the task calls for it.

## Hardware Safety

- Treat the oscilloscope input ground clips as electrically common and connected through the USB host. Verify the actual grounding arrangement before making a measurement.
- Never attach a ground clip to a mains-referenced or otherwise energized node unless the measurement setup is specifically designed and rated for it.
- Use properly rated differential or isolated equipment for floating, high-voltage, or mains measurements. An isolated laptop does not turn an ordinary probe into a safe differential probe.
- Check the instrument, probe, and selected attenuation limits before applying a signal. Use the lowest-risk setup that preserves the needed bandwidth and resolution.
- Power down the circuit before moving clips when practical. Connect ground first and remove it last.
- Begin with conservative voltage and timebase settings when the signal amplitude is unknown.
- Do not infer safety limits from software controls. Consult the device and probe documentation.

If a requested procedure could damage the scope, computer, circuit, or user, stop and explain the specific risk before operating the hardware.

## Preferred Workspace Layout

Create only the directories needed for the current task:

```text
docs/               setup notes, procedures, and measurement records
scripts/            repeatable acquisition and analysis commands
captures/raw/       original scope exports; preserve unchanged
captures/processed/ derived or cleaned data
plots/              generated figures
fixtures/           reusable test signals and reference data
```

Do not commit large capture files, generated plots, or local application state by default. Add an intentional `.gitignore` when the repository is initialized.

## Acquisition and Data Rules

- Prefer scriptable, reproducible acquisition when the installed driver or application supports it.
- Preserve raw captures. Put transformed data in `captures/processed/`.
- Store enough metadata to reproduce each meaningful capture: UTC timestamp, channel, coupling, volts/div or input range, timebase or sample rate, probe attenuation, trigger settings, signal source, software and driver, and any post-processing.
- Use stable, descriptive filenames such as `2026-10-19T213000Z_uart-rx_ch1_10x.csv`.
- Record units in column names or metadata. Never leave voltage, time, or frequency units implicit.
- Keep calibration factors and corrections explicit. Do not overwrite measured values with unexplained adjustments.
- When comparing captures, keep acquisition settings consistent or call out each difference.

## Tooling

Several applications and libraries can support this scope. First identify what is installed and what works on the host; then document the chosen path in `docs/setup.md`. Prefer maintained, open tooling and machine-readable exports when it meets the task.

For shell commands in this workspace, follow the RTK requirement from the user environment: prefix every command, and every segment of a command chain, with `rtk`. Use an unfiltered command only for debugging when RTK obscures required output.

Keep hardware-access code separated from analysis code so saved captures can be tested without the oscilloscope attached. Pin dependencies once the first toolchain is selected. Never add credentials, machine-specific absolute paths, or copied proprietary binaries to the workspace.

## Verification

For acquisition changes, verify the smallest complete path available:

1. The host detects the USB device.
2. The selected software opens the device without repeated disconnects or permission errors.
3. A known safe test signal produces a plausible waveform on each channel used.
4. Exported data has the expected sample count, timing, amplitude, and units.
5. Analysis scripts reproduce their plots or reported measurements from a saved raw capture.

Report which checks required physical hardware and which were completed from saved data. Never claim a hardware result from a mocked or synthetic capture.

## Documentation and Change Style

- Keep setup instructions specific enough to repeat, including OS and relevant software versions.
- Explain wiring in words or a small diagram whenever clip placement is not obvious.
- Put reusable commands in scripts instead of leaving long one-off shell snippets in notes.
- Make focused changes and preserve unrelated user files and measurements.
- Before finishing, summarize what changed, how it was verified, and any step that still needs the connected instrument.
