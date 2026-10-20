import SwiftUI

struct ScopeWorkspaceView: View {
    var body: some View {
        NavigationSplitView {
            List {
                Section("Channels") {
                    ChannelRow(name: "Channel 1", color: .yellow, scale: "1.00 V/div")
                    ChannelRow(name: "Channel 2", color: .cyan, scale: "1.00 V/div")
                }

                Section("Instrument") {
                    Label("No scope connected", systemImage: "cable.connector.slash")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("OpenHantek Studio")
            .navigationSplitViewColumnWidth(min: 210, ideal: 240)
        } detail: {
            VStack(spacing: 0) {
                acquisitionBar
                ScopePlaceholderView()
                measurementBar
            }
            .background(Color(nsColor: .windowBackgroundColor))
        }
    }

    private var acquisitionBar: some View {
        HStack(spacing: 16) {
            Button("Run", systemImage: "play.fill") {}
                .disabled(true)
            Button("Single", systemImage: "scope") {}
                .disabled(true)
            Divider().frame(height: 20)
            LabeledContent("Timebase", value: "1.00 ms/div")
            LabeledContent("Trigger", value: "CH1 · Rising · 0.00 V")
            Spacer()
            Label("Disconnected", systemImage: "circle.fill")
                .foregroundStyle(.secondary)
        }
        .buttonStyle(.borderless)
        .padding(.horizontal, 18)
        .frame(height: 50)
    }

    private var measurementBar: some View {
        HStack(spacing: 24) {
            LabeledContent("Frequency", value: "—")
            LabeledContent("Period", value: "—")
            LabeledContent("Peak-to-peak", value: "—")
            Spacer()
            Text("Demo interface · hardware bridge pending")
                .foregroundStyle(.tertiary)
        }
        .font(.callout.monospacedDigit())
        .padding(.horizontal, 18)
        .frame(height: 44)
    }
}

private struct ChannelRow: View {
    let name: String
    let color: Color
    let scale: String

    var body: some View {
        HStack(spacing: 10) {
            Circle()
                .fill(color)
                .frame(width: 9, height: 9)
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                Text(scale)
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
        }
    }
}

private struct ScopePlaceholderView: View {
    var body: some View {
        Canvas { context, size in
            let bounds = CGRect(origin: .zero, size: size)
            context.fill(Path(bounds), with: .color(Color(red: 0.035, green: 0.045, blue: 0.055)))

            var grid = Path()
            for column in 0...10 {
                let x = size.width * CGFloat(column) / 10
                grid.move(to: CGPoint(x: x, y: 0))
                grid.addLine(to: CGPoint(x: x, y: size.height))
            }
            for row in 0...8 {
                let y = size.height * CGFloat(row) / 8
                grid.move(to: CGPoint(x: 0, y: y))
                grid.addLine(to: CGPoint(x: size.width, y: y))
            }
            context.stroke(grid, with: .color(.white.opacity(0.10)), lineWidth: 1)

            var center = Path()
            center.move(to: CGPoint(x: size.width / 2, y: 0))
            center.addLine(to: CGPoint(x: size.width / 2, y: size.height))
            center.move(to: CGPoint(x: 0, y: size.height / 2))
            center.addLine(to: CGPoint(x: size.width, y: size.height / 2))
            context.stroke(center, with: .color(.white.opacity(0.22)), lineWidth: 1)

            var trace = Path()
            let amplitude = size.height * 0.22
            let centerY = size.height / 2
            let samples = max(2, Int(size.width))
            for sample in 0..<samples {
                let x = CGFloat(sample) / CGFloat(samples - 1) * size.width
                let phase = CGFloat(sample) / CGFloat(samples - 1) * .pi * 8
                let y = centerY - sin(phase) * amplitude
                if sample == 0 {
                    trace.move(to: CGPoint(x: x, y: y))
                } else {
                    trace.addLine(to: CGPoint(x: x, y: y))
                }
            }
            context.stroke(trace, with: .color(.yellow.opacity(0.92)), lineWidth: 1.5)
        }
        .overlay(alignment: .topLeading) {
            Text("PREVIEW")
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.white.opacity(0.45))
                .padding(12)
        }
        .padding(12)
    }
}
