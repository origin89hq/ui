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

React: install the `origin89-ui-react-0.1.0.tgz` asset from the `v0.1.0` GitHub release. Import `Reading` or `EquipmentIllustration` from `@origin89/ui-react` and import `@origin89/ui-react/styles.css`. For example:

```tsx
<Reading label="Battery" reading={{ state: "current", value: 76, unit: "%" }} />
```

Swift: add `https://github.com/origin89hq/ui` as a Swift package dependency at `0.1.0`, link `Origin89UI`, then use `Origin89Reading`. Native previews include current, zero, stale and unknown examples.

Android: the `platforms/compose` Gradle project builds an Android library. Run `./gradlew :ui:publishToMavenLocal` there, add `mavenLocal()` to a consuming development project and depend on `com.origin89:ui-compose:0.1.0`. Release AAR and source artifacts are also attached to GitHub releases; Maven Central publication is not configured yet.

## Brand and releases

`pnpm brand:generate` derives native tokens, fonts and license resources from the pinned `@origin89/brand` release. `brand-provenance.json` records input and output hashes; `pnpm brand:check` rejects drift. Update the package version and regenerate these files together. Do not hand-edit generated palettes.

Run all three platform checks before a release. `just package` produces the React tarball; Swift consumers use the repository tag; `platforms/compose/gradlew` builds Android artifacts from that same tag. No mobile or web runtime depends on a controller checkout. Extracted web illustrations originate from `origin89hq/origin89` commit `7dc27cd9e5f7f7ae67b519b037ca600265012d1e`.

See [LICENSING.md](LICENSING.md): first-party source is public for review while its software license is being selected. Brand and font terms remain separate.

## npm releases

`@origin89/ui-react` is published by `.github/workflows/publish-react.yml` using npm trusted publishing with provenance. Configure the npm package's GitHub trusted publisher for organization `origin89hq`, repository `ui`, workflow `publish-react.yml`, and no environment. Allow direct publishing. No npm token belongs in repository secrets.

The initial `0.0.0` bootstrap creates the npm package so its trusted publisher can be configured. Release versions stay in `packages/react/package.json`. After merging a checked version change, push `ui-react-v<version>` at that main-branch commit. The workflow checks the tag, builds and validates the package, and publishes its tarball. Existing `v0.1.0` GitHub release assets remain available.
