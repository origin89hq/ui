import CoreText
import SwiftUI
import Testing
@testable import Origin89UI

private func colors(_ palette: Origin89Palette) -> [(String, Color)] {
    Mirror(reflecting: palette).children.compactMap { child in
        guard let label = child.label, let color = child.value as? Color else { return nil }
        return (label, color)
    }
}
// AppKit resolves appearance-backed colours on the main thread; off it, resolve(in:) never returns.
@MainActor private func resolved(_ color: Color, in scheme: ColorScheme) -> Color.Resolved {
    var environment = EnvironmentValues()
    environment.colorScheme = scheme
    return color.resolve(in: environment)
}
/// The platform colour round trip changes the last float bits, not the 8-bit value.
private func same(_ a: Color.Resolved, _ b: Color.Resolved) -> Bool {
    zip([a.red, a.green, a.blue, a.opacity], [b.red, b.green, b.blue, b.opacity]).allSatisfy { abs($0 - $1) < 0.0005 }
}

@Test(arguments: [ColorScheme.light, .dark])
@MainActor func adaptiveColorsFollowTheScheme(scheme: ColorScheme) {
    let expected = colors(scheme == .dark ? Origin89Tokens.dark : Origin89Tokens.light)
    let adaptive = colors(Origin89Tokens.adaptive)
    #expect(adaptive.count == 20)
    #expect(adaptive.map(\.0) == expected.map(\.0))
    for ((name, color), (_, fixed)) in zip(adaptive, expected) {
        #expect(same(resolved(color, in: scheme), resolved(fixed, in: scheme)), "\(name) in \(scheme)")
    }
}
@Test @MainActor func adaptiveColorsChangeWithTheScheme() {
    let page = Origin89Tokens.adaptive.page
    #expect(!same(resolved(page, in: .light), resolved(page, in: .dark)))
}
@Test @MainActor func shapeStyleShorthandUsesTheAdaptivePalette() {
    let style: Color = .origin89.fg
    #expect(same(resolved(style, in: .dark), resolved(Origin89Tokens.dark.fg, in: .dark)))
}
@Test func fontStylesRegisterTheBundledFaces() {
    _ = Font.origin89Label
    Origin89Fonts.register()
    for name in ["InterTight-Regular", "InterTight-SemiBold", "IBMPlexMono-Regular"] {
        #expect(CTFontCopyPostScriptName(CTFontCreateWithName(name as CFString, 12, nil)) as String == name)
    }
}
