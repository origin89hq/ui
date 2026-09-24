// Generated from @origin89/brand 0.3.1; run pnpm brand:generate.
import SwiftUI
public struct Origin89Palette: Sendable {
    public let page: Color
    public let surface: Color
    public let surfaceRaised: Color
    public let line: Color
    public let lineStrong: Color
    public let focus: Color
    public let fg: Color
    public let muted: Color
    public let faint: Color
    public let action: Color
    public let actionLit: Color
    public let link: Color
    public let onFill: Color
    public let nominal: Color
    public let warning: Color
    public let nominalDeep: Color
    public let warningDeep: Color
    public let alarm: Color
    public let alarmDeep: Color
    public let info: Color
}
public enum Origin89Tokens {
    public static let light = Origin89Palette(
        page: Color(red: 251/255.0, green: 252/255.0, blue: 250/255.0),
        surface: Color(red: 241/255.0, green: 243/255.0, blue: 240/255.0),
        surfaceRaised: Color(red: 255/255.0, green: 255/255.0, blue: 255/255.0),
        line: Color(red: 223/255.0, green: 227/255.0, blue: 230/255.0),
        lineStrong: Color(red: 196/255.0, green: 204/255.0, blue: 210/255.0),
        focus: Color(red: 43/255.0, green: 74/255.0, blue: 151/255.0),
        fg: Color(red: 17/255.0, green: 22/255.0, blue: 26/255.0),
        muted: Color(red: 75/255.0, green: 87/255.0, blue: 97/255.0),
        faint: Color(red: 105/255.0, green: 116/255.0, blue: 125/255.0),
        action: Color(red: 43/255.0, green: 74/255.0, blue: 151/255.0),
        actionLit: Color(red: 63/255.0, green: 97/255.0, blue: 179/255.0),
        link: Color(red: 43/255.0, green: 74/255.0, blue: 151/255.0),
        onFill: Color(red: 255/255.0, green: 255/255.0, blue: 255/255.0),
        nominal: Color(red: 76/255.0, green: 125/255.0, blue: 95/255.0),
        warning: Color(red: 159/255.0, green: 102/255.0, blue: 1/255.0),
        nominalDeep: Color(red: 76/255.0, green: 125/255.0, blue: 95/255.0),
        warningDeep: Color(red: 162/255.0, green: 100/255.0, blue: 5/255.0),
        alarm: Color(red: 202/255.0, green: 70/255.0, blue: 40/255.0),
        alarmDeep: Color(red: 166/255.0, green: 59/255.0, blue: 37/255.0),
        info: Color(red: 72/255.0, green: 120/255.0, blue: 153/255.0)
    )
    public static let dark = Origin89Palette(
        page: Color(red: 7/255.0, green: 9/255.0, blue: 12/255.0),
        surface: Color(red: 13/255.0, green: 17/255.0, blue: 22/255.0),
        surfaceRaised: Color(red: 18/255.0, green: 23/255.0, blue: 30/255.0),
        line: Color(red: 30/255.0, green: 37/255.0, blue: 46/255.0),
        lineStrong: Color(red: 43/255.0, green: 52/255.0, blue: 63/255.0),
        focus: Color(red: 255/255.0, green: 255/255.0, blue: 255/255.0),
        fg: Color(red: 231/255.0, green: 234/255.0, blue: 238/255.0),
        muted: Color(red: 154/255.0, green: 165/255.0, blue: 177/255.0),
        faint: Color(red: 112/255.0, green: 123/255.0, blue: 135/255.0),
        action: Color(red: 43/255.0, green: 74/255.0, blue: 151/255.0),
        actionLit: Color(red: 63/255.0, green: 97/255.0, blue: 179/255.0),
        link: Color(red: 98/255.0, green: 121/255.0, blue: 173/255.0),
        onFill: Color(red: 255/255.0, green: 255/255.0, blue: 255/255.0),
        nominal: Color(red: 47/255.0, green: 157/255.0, blue: 100/255.0),
        warning: Color(red: 233/255.0, green: 161/255.0, blue: 60/255.0),
        nominalDeep: Color(red: 22/255.0, green: 140/255.0, blue: 84/255.0),
        warningDeep: Color(red: 177/255.0, green: 114/255.0, blue: 31/255.0),
        alarm: Color(red: 224/255.0, green: 90/255.0, blue: 60/255.0),
        alarmDeep: Color(red: 166/255.0, green: 59/255.0, blue: 37/255.0),
        info: Color(red: 127/255.0, green: 176/255.0, blue: 212/255.0)
    )
    /// Colours that follow the current light or dark appearance.
    public static let adaptive = Origin89Palette(
        page: Color(light: light.page, dark: dark.page),
        surface: Color(light: light.surface, dark: dark.surface),
        surfaceRaised: Color(light: light.surfaceRaised, dark: dark.surfaceRaised),
        line: Color(light: light.line, dark: dark.line),
        lineStrong: Color(light: light.lineStrong, dark: dark.lineStrong),
        focus: Color(light: light.focus, dark: dark.focus),
        fg: Color(light: light.fg, dark: dark.fg),
        muted: Color(light: light.muted, dark: dark.muted),
        faint: Color(light: light.faint, dark: dark.faint),
        action: Color(light: light.action, dark: dark.action),
        actionLit: Color(light: light.actionLit, dark: dark.actionLit),
        link: Color(light: light.link, dark: dark.link),
        onFill: Color(light: light.onFill, dark: dark.onFill),
        nominal: Color(light: light.nominal, dark: dark.nominal),
        warning: Color(light: light.warning, dark: dark.warning),
        nominalDeep: Color(light: light.nominalDeep, dark: dark.nominalDeep),
        warningDeep: Color(light: light.warningDeep, dark: dark.warningDeep),
        alarm: Color(light: light.alarm, dark: dark.alarm),
        alarmDeep: Color(light: light.alarmDeep, dark: dark.alarmDeep),
        info: Color(light: light.info, dark: dark.info)
    )
}
