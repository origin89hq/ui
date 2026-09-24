skills-sync:
    python3 .origin89/sync-engineering.py
check:
    pnpm check
swift-check:
    swift test
swift-release version:
    gh workflow run release-swift.yml --repo origin89hq/ui --ref main -f "version={{version}}"
android-check:
    cd platforms/compose && ./gradlew check assembleRelease
package:
    pnpm build
    pnpm package
