import SwiftUI

public enum ReadingValue: Equatable, Sendable {
    case current(value: Double, unit: String)
    case stale(value: Double, unit: String, age: String)
    case unknown

    public var description: String {
        switch self {
        case .unknown: return "Unknown"
        case let .current(value, unit): return Self.format(value, unit: unit)
        case let .stale(value, unit, age):
            guard value.isFinite else { return "Unknown" }
            return "\(Self.format(value, unit: unit)) · Last known · \(age)"
        }
    }
    private static func format(_ value: Double, unit: String) -> String {
        guard value.isFinite else { return "Unknown" }
        let text = value == 0 ? "0" : String(value)
        let number = text.hasSuffix(".0") ? String(text.dropLast(2)) : text
        return "\(number) \(unit)".trimmingCharacters(in: .whitespaces)
    }
}

public struct Origin89Reading: View {
    public let label: String
    public let reading: ReadingValue
    public init(_ label: String, reading: ReadingValue) {
        self.label = label
        self.reading = reading
    }
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label).font(.origin89Label).foregroundStyle(.origin89.muted)
            Text(reading.description).font(.origin89Value).monospacedDigit().foregroundStyle(.origin89.fg)
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .bottom) { Rectangle().fill(.origin89.line).frame(height: 1) }
        .accessibilityElement(children: .combine)
    }
}

#Preview("Current, stale, unknown") {
    VStack {
        Origin89Reading("Battery", reading: .current(value: 76, unit: "%"))
        Origin89Reading("Solar", reading: .current(value: 0, unit: "kW"))
        Origin89Reading("Battery", reading: .stale(value: 78, unit: "%", age: "12 min ago"))
        Origin89Reading("Solar", reading: .unknown)
    }.padding()
}
