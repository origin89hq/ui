import SwiftUI
import Testing
@testable import Origin89UI

@Test func statusTonesStayDistinctWithoutColour() {
    // Mark and border together must tell every tone apart, as they do on the web.
    let looks = Origin89StatusTone.allCases.map { "\($0.mark)|\($0.border.lineWidth)|\($0.border.dash)" }
    #expect(Set(looks).count == Origin89StatusTone.allCases.count)
    #expect(Origin89StatusTone.nominal.mark == "\u{2713}")
    #expect(Origin89StatusTone.alarm.mark == "!")
    #expect(Origin89StatusTone.alarm.border.lineWidth == 2)
}
@Test func statusTonesUseTheirBrandColour() {
    let expected: [Origin89StatusTone: KeyPath<Origin89Palette, Color>] = [
        .nominal: \.nominal, .alarm: \.alarm, .warning: \.warning, .info: \.info, .faint: \.faint,
    ]
    for tone in Origin89StatusTone.allCases { #expect(tone.color == expected[tone], "\(tone)") }
}
@Test func onlyAlarmNoticesAnnounce() {
    #expect(Origin89NoticeTone.alarm.announces)
    #expect(!Origin89NoticeTone.info.announces)
    #expect(Origin89NoticeTone.alarm.text == \Origin89Palette.alarm)
    #expect(Origin89NoticeTone.info.text == \Origin89Palette.muted)
}
@MainActor @Test func defaultsMatchTheWeb() {
    #expect(Origin89Status("Pending").tone == .faint)
    #expect(Origin89Notice("Note").tone == .info)
    #expect(Origin89Loading().label == "Loading\u{2026}")
}
@Test func bevelCutsEveryCornerAndClampsToSmallRects() {
    let square = BevelRectangle(corner: 10).path(in: CGRect(x: 0, y: 0, width: 100, height: 40))
    #expect(!square.contains(CGPoint(x: 1, y: 1)))
    #expect(!square.contains(CGPoint(x: 99, y: 39)))
    #expect(square.contains(CGPoint(x: 50, y: 20)))
    let tiny = BevelRectangle(corner: 10).path(in: CGRect(x: 0, y: 0, width: 6, height: 6))
    #expect(tiny.contains(CGPoint(x: 3, y: 3)))
    #expect(BevelRectangle(corner: 10).inset(by: 12).path(in: CGRect(x: 0, y: 0, width: 100, height: 40)).contains(CGPoint(x: 50, y: 20)))
}
@MainActor @Test(arguments: [ColorScheme.light, .dark])
func componentsRenderInBothSchemes(scheme: ColorScheme) throws {
    let views: [AnyView] = Origin89StatusTone.allCases.map { AnyView(Origin89Status("Paired", tone: $0)) }
        + Origin89NoticeTone.allCases.map { AnyView(Origin89Notice("", tone: $0)) }
        + [AnyView(Origin89Notice(String(repeating: "Wrong proof. ", count: 40), tone: .alarm)), AnyView(Origin89Loading(""))]
    for view in views {
        let renderer = ImageRenderer(content: view.frame(width: 320).environment(\.colorScheme, scheme))
        let image = try #require(renderer.cgImage)
        #expect(image.width > 0 && image.height > 0)
    }
}
