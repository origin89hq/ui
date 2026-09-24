import SwiftUI

public enum Origin89NoticeTone: Sendable, CaseIterable {
    case info, alarm

    var color: KeyPath<Origin89Palette, Color> {
        switch self {
        case .info: \.info
        case .alarm: \.alarm
        }
    }
    var text: KeyPath<Origin89Palette, Color> {
        switch self {
        case .info: \.muted
        case .alarm: \.alarm
        }
    }
    /// An alarm announces itself; an info notice waits to be read, so VoiceOver is not interrupted.
    var announces: Bool {
        switch self {
        case .info: false
        case .alarm: true
        }
    }
}

/// A line of consequence above the thing it concerns, such as a refusal from the controller.
public struct Origin89Notice: View {
    public let message: String
    public let tone: Origin89NoticeTone
    public init(_ message: String, tone: Origin89NoticeTone = .info) {
        self.message = message
        self.tone = tone
    }
    public var body: some View {
        let shape = BevelRectangle(corner: 10)
        Text(message)
            .font(.origin89Label)
            .lineSpacing(4)
            .foregroundStyle(Origin89Tokens.adaptive[keyPath: tone.text])
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(.origin89.surface)
            .overlay(alignment: .leading) {
                Rectangle().fill(Origin89Tokens.adaptive[keyPath: tone.color]).frame(width: 3)
            }
            .clipShape(shape)
            .overlay { shape.strokeBorder(.origin89.line, lineWidth: 1) }
            .accessibilityElement(children: .combine)
            .onAppear(perform: announce)
            .onChange(of: message) { announce() }
    }
    private func announce() {
        guard tone.announces else { return }
        AccessibilityNotification.Announcement(message).post()
    }
}

#Preview("Tones") {
    VStack(spacing: 12) {
        Origin89Notice("Open the pairing window at the panel, then pair within 120 seconds.")
        Origin89Notice("The controller refused the proof. Check the QR code and try again.", tone: .alarm)
    }.padding()
}
