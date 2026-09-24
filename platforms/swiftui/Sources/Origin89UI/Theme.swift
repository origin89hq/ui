import SwiftUI
import CoreText
#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

extension Color {
    init(light: Color, dark: Color) {
        #if canImport(UIKit)
        self.init(uiColor: UIColor { $0.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light) })
        #else
        self.init(nsColor: NSColor(name: nil) { appearance in
            appearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua ? NSColor(dark) : NSColor(light)
        })
        #endif
    }
}

public extension ShapeStyle where Self == Color {
    /// Brand colours that follow the current appearance, as in `.foregroundStyle(.origin89.muted)`.
    static var origin89: Origin89Palette { Origin89Tokens.adaptive }
}

public enum Origin89Fonts {
    private static let registration: Void = {
        for name in ["InterTight-400", "InterTight-600", "IBMPlexMono-Regular"] {
            guard let url = Bundle.module.url(forResource: name, withExtension: "ttf") else {
                preconditionFailure("Missing bundled Origin89 font: \(name)")
            }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }()
    /// Registers the bundled fonts once per process. The `Font.origin89*` styles call this.
    public static func register() { _ = registration }
}

public extension Font {
    /// Inter Tight 14, scaling with `.subheadline`.
    static var origin89Label: Font { brand("InterTight-Regular", size: 14, relativeTo: .subheadline) }
    /// Inter Tight SemiBold 24, scaling with `.title2`.
    static var origin89Value: Font { brand("InterTight-SemiBold", size: 24, relativeTo: .title2) }
    /// IBM Plex Mono 12, scaling with `.caption`, for tags, statuses and identifiers.
    static var origin89Data: Font { brand("IBMPlexMono-Regular", size: 12, relativeTo: .caption) }

    private static func brand(_ name: String, size: CGFloat, relativeTo style: Font.TextStyle) -> Font {
        Origin89Fonts.register()
        return .custom(name, size: size, relativeTo: style)
    }
}

/// The brand's bevelled corner: a straight cut `corner` points along each edge.
struct BevelRectangle: InsettableShape {
    var corner: CGFloat
    var inset: CGFloat = 0
    func path(in rect: CGRect) -> Path {
        let r = rect.insetBy(dx: inset, dy: inset)
        let c = max(0, min(corner - inset, r.width / 2, r.height / 2))
        var path = Path()
        path.move(to: CGPoint(x: r.minX + c, y: r.minY))
        path.addLine(to: CGPoint(x: r.maxX - c, y: r.minY))
        path.addLine(to: CGPoint(x: r.maxX, y: r.minY + c))
        path.addLine(to: CGPoint(x: r.maxX, y: r.maxY - c))
        path.addLine(to: CGPoint(x: r.maxX - c, y: r.maxY))
        path.addLine(to: CGPoint(x: r.minX + c, y: r.maxY))
        path.addLine(to: CGPoint(x: r.minX, y: r.maxY - c))
        path.addLine(to: CGPoint(x: r.minX, y: r.minY + c))
        path.closeSubpath()
        return path
    }
    func inset(by amount: CGFloat) -> BevelRectangle { BevelRectangle(corner: corner, inset: inset + amount) }
}
