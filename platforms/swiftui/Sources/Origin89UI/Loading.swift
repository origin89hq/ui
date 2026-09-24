import SwiftUI

/// Work in progress. The bars are the shape of what is coming rather than a bare spinner, and
/// both the spinner and the bars stop under Reduce Motion.
public struct Origin89Loading: View {
    public let label: String
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var pulse = false
    @State private var spin = false
    public init(_ label: String = "Loading\u{2026}") {
        self.label = label
    }
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 10) {
                ZStack {
                    Circle().strokeBorder(.origin89.lineStrong, lineWidth: 2)
                    Circle().inset(by: 1).trim(from: 0, to: 0.25).stroke(.origin89.signal, lineWidth: 2)
                }
                .frame(width: 13, height: 13)
                .rotationEffect(.degrees(spin ? 360 : 0))
                .accessibilityHidden(true)
                Text(label).font(.origin89Label).foregroundStyle(.origin89.muted)
            }
            .accessibilityElement(children: .combine)
            VStack(alignment: .leading, spacing: 16) {
                ForEach(0..<4, id: \.self) { bar in
                    GeometryReader { proxy in
                        Rectangle().fill(.origin89.line)
                            .frame(width: bar.isMultiple(of: 2) ? proxy.size.width : proxy.size.width * 0.8)
                    }
                    .frame(height: 32)
                }
            }
            .opacity(reduceMotion ? 0.5 : (pulse ? 0.7 : 0.35))
            .accessibilityHidden(true)
        }
        .padding(.vertical, 24)
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) { pulse = true }
            withAnimation(.linear(duration: 0.9).repeatForever(autoreverses: false)) { spin = true }
        }
    }
}

#Preview("Loading") {
    Origin89Loading("Reading the network section\u{2026}").padding()
}
