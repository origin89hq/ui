skills-sync:
    python3 .origin89/sync-engineering.py
check:
    pnpm check
swift-check:
    swift test
android-check:
    cd platforms/compose && ./gradlew check assembleRelease
package:
    pnpm build
    pnpm package
