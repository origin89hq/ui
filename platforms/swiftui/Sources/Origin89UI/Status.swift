import SwiftUI

/// How a status chip looks. The tone is the presentation, not the meaning: the application maps
/// its own states onto these. Each tone pairs its hue with a border style and a mark, so the chip
/// still reads without colour.
public enum Origin89StatusTone: Sendable, CaseIterable {
    case nominal, alarm, warning, info, faint

    var mark: String {
        switch self {
        case .nominal: "\u{2713}"
        case .alarm: "!"
        case .warning, .info, .faint: "\u{2022}"
        }
    }
    var color: KeyPath<Origin89Palette, Color> {
        switch self {
        case .nominal: \.nominal
        case .alarm: \.alarm
        case .warning: \.warning
        case .info: \.info
        case .faint: \.faint
        }
    }
    var border: StrokeStyle {
        switch self {
        case .nominal, .info: StrokeStyle(lineWidth: 1)
        case .alarm: StrokeStyle(lineWidth: 2)
        case .warning: StrokeStyle(lineWidth: 1, dash: [4, 3])
        case .faint: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [0.5, 2.5])
        }
    }
}

/// A state chip, such as a setup step that is pending, running, done or refused.
public struct Origin89Status: View {
    public let title: String
    public let tone: Origin89StatusTone
    public init(_ title: String, tone: Origin89StatusTone = .faint) {
        self.title = title
        self.tone = tone
    }
    public var body: some View {
        HStack(spacing: 6) {
            Text(tone.mark).accessibilityHidden(true)
            Text(title)
        }
        .font(.origin89Data)
        .lineLimit(1)
        .padding(.vertical, 3)
        .padding(.horizontal, 8)
        .overlay { Rectangle().strokeBorder(style: tone.border) }
        .foregroundStyle(Origin89Tokens.adaptive[keyPath: tone.color])
        .accessibilityElement(children: .combine)
    }
}

#Preview("Tones") {
    VStack(alignment: .leading, spacing: 12) {
        Origin89Status("Paired", tone: .nominal)
        Origin89Status("Wrong proof", tone: .alarm)
        Origin89Status("Window closing", tone: .warning)
        Origin89Status("Pairing", tone: .info)
        Origin89Status("Not started")
    }.padding()
}
