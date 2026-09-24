# Origin89 UI

Shared interface foundations with native implementations for React, SwiftUI and Jetpack Compose. [Brand](https://github.com/origin89hq/brand) owns the identity, fonts and palette; this repository owns interface behavior and components. Product screens stay in their application repositories.

| Platform | Package | Available base |
| --- | --- | --- |
| Web | `@origin89/ui-react` | Reading, equipment illustrations, styles |
| Apple | Swift package `Origin89UI` | Native Reading, dynamic type, fonts and light/dark tokens |
| Android | `com.origin89:ui-compose` | Native Compose Reading, fonts and light/dark tokens |

All three distinguish current, stale and unknown values. Zero is a valid measurement; non-finite values display as unknown. Shared JSON examples exercise these states across platforms. This is a usable foundation, not a complete mobile application or a shared screen runtime.

```sh
pnpm install --frozen-lockfile
just check
just swift-check
just android-check
```

Use the pinned Node/pnpm versions. Apple builds require Xcode with Swift 6; minimum targets are iOS 17 and macOS 14. Android uses the checked Gradle wrapper, JDK 17 or later and Android SDK 37. Set `ANDROID_HOME` or an ignored `platforms/compose/local.properties` SDK path.

## Consume

React: install `@origin89/ui-react` from npm. Import `Reading` or `EquipmentIllustration` from `@origin89/ui-react` and import `@origin89/ui-react/styles.css`. For example:

```tsx
<Reading label="Battery" reading={{ state: "current", value: 76, unit: "%" }} />
```

Swift: add `https://github.com/origin89hq/ui` as a Swift package dependency with an exact version such as `0.2.0`, link `Origin89UI`, then use `Origin89Reading`. Brand colours follow light and dark mode through `.foregroundStyle(.origin89.muted)` or `Color.origin89.surface`; fixed palettes stay available as `Origin89Tokens.light` and `.dark`. Text styles such as `.font(.origin89Label)` register the bundled fonts. Native previews include current, zero, stale and unknown examples.

Android: the `platforms/compose` Gradle project builds an Android library. Run `./gradlew :ui:publishToMavenLocal` there, add `mavenLocal()` to a consuming development project and depend on `com.origin89:ui-compose:0.1.0`. Release AAR and source artifacts are also attached to GitHub releases; Maven Central publication is not configured yet.

## Brand and releases

`pnpm brand:generate` derives native tokens, fonts and license resources from the pinned `@origin89/brand` release. `brand-provenance.json` records input and output hashes; `pnpm brand:check` rejects drift. Update the package version and regenerate these files together. Do not hand-edit generated palettes.

Run all three platform checks before a release. `just package` produces the React tarball. The Swift package is versioned separately from npm: `just swift-release 0.3.0` runs the `release-swift` workflow on `main`, which checks the version, runs the Swift tests and iOS Simulator build, then tags that commit `0.3.0` for Swift Package Manager. `platforms/compose/gradlew` builds Android artifacts from a checkout. No mobile or web runtime depends on a controller checkout. Extracted web illustrations originate from `origin89hq/origin89` commit `7dc27cd9e5f7f7ae67b519b037ca600265012d1e`.

See [LICENSING.md](LICENSING.md): first-party source is public for review while its software license is being selected. Brand and font terms remain separate.

## npm releases

Run `pnpm changeset` with each change that affects `@origin89/ui-react` consumers. Include the release note and bump choice in the feature PR. The release workflow collects those notes into a version PR with `packages/react/CHANGELOG.md`. Review and merge that PR to publish through npm OIDC and create the GitHub release notes.

See [the release guide](docs/releases.md) for package scope, validation, the initial npm release and recovery. The configured trusted-publisher filename remains `publish-react.yml`.
