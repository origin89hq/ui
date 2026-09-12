import assert from "node:assert/strict";
import { createHash } from "node:crypto";
import { mkdir, readFile, writeFile } from "node:fs/promises";

const root = new URL("../", import.meta.url);
const brandRoot = new URL("node_modules/@origin89/brand/", root);
const brandBytes = await readFile(new URL("brand.json", brandRoot));
const brand = JSON.parse(brandBytes);
const version = JSON.parse(await readFile(new URL("package.json", brandRoot), "utf8")).version;
assert.equal(version, "0.3.1");
const outputs = new Map();
const camel = (value) => value.replace(/-([a-z])/g, (_, letter) => letter.toUpperCase());
const keys = Object.keys(brand.colour.themes.light);
assert.deepEqual(Object.keys(brand.colour.themes.dark), keys);
const rgb = (hex) => {
  assert.match(hex, /^#[0-9a-f]{6}$/i);
  return [1, 3, 5].map((index) => Number.parseInt(hex.slice(index, index + 2), 16));
};
const swiftPalette = (theme) =>
  keys
    .map((key) => {
      const [r, g, b] = rgb(brand.colour.themes[theme][key]);
      return `        ${camel(key)}: Color(red: ${r}/255.0, green: ${g}/255.0, blue: ${b}/255.0)`;
    })
    .join(",\n");
outputs.set(
  "platforms/swiftui/Sources/Origin89UI/GeneratedTokens.swift",
  `// Generated from @origin89/brand ${version}; run pnpm brand:generate.\nimport SwiftUI\npublic struct Origin89Palette: Sendable {\n${keys.map((key) => `    public let ${camel(key)}: Color`).join("\n")}\n}\npublic enum Origin89Tokens {\n    public static let light = Origin89Palette(\n${swiftPalette("light")}\n    )\n    public static let dark = Origin89Palette(\n${swiftPalette("dark")}\n    )\n}\n`,
);
const kotlinPalette = (theme) =>
  keys
    .map(
      (key) =>
        `        ${camel(key)} = Color(0xFF${brand.colour.themes[theme][key].slice(1).toUpperCase()})`,
    )
    .join(",\n");
outputs.set(
  "platforms/compose/ui/src/main/kotlin/com/origin89/ui/GeneratedTokens.kt",
  `// Generated from @origin89/brand ${version}; run pnpm brand:generate.\npackage com.origin89.ui\nimport androidx.compose.ui.graphics.Color\ndata class Origin89Palette(\n${keys.map((key) => `    val ${camel(key)}: Color`).join(",\n")}\n)\nobject Origin89Tokens {\n    val light = Origin89Palette(\n${kotlinPalette("light")}\n    )\n    val dark = Origin89Palette(\n${kotlinPalette("dark")}\n    )\n}\n`,
);
const sources = [
  { file: "brand.json", sha256: createHash("sha256").update(brandBytes).digest("hex") },
];
for (const [name, android] of [
  ["InterTight-400.ttf", "inter_tight_regular.ttf"],
  ["InterTight-600.ttf", "inter_tight_semibold.ttf"],
  ["IBMPlexMono-Regular.ttf", "ibm_plex_mono.ttf"],
  ["InterTight-OFL.txt", null],
  ["IBMPlexMono-OFL.txt", null],
]) {
  assert.ok(
    [
      ...brand.typography.text.files,
      ...brand.typography.data.files,
      brand.typography.text.licence,
      brand.typography.data.licence,
    ].includes(`fonts/${name}`),
  );
  const bytes = await readFile(new URL(`fonts/${name}`, brandRoot));
  sources.push({ file: `fonts/${name}`, sha256: createHash("sha256").update(bytes).digest("hex") });
  outputs.set(`platforms/swiftui/Sources/Origin89UI/Resources/${name}`, bytes);
  outputs.set(
    android
      ? `platforms/compose/ui/src/main/res/font/${android}`
      : `platforms/compose/ui/src/main/resources/licenses/${name}`,
    bytes,
  );
}
const fixtures = await readFile(new URL("fixtures/readings.json", root));
outputs.set("platforms/swiftui/Tests/Origin89UITests/Fixtures/readings.json", fixtures);
outputs.set("platforms/compose/ui/src/test/resources/readings.json", fixtures);
outputs.set(
  "brand-provenance.json",
  JSON.stringify(
    {
      package: "@origin89/brand",
      version,
      sources,
      outputs: [...outputs].map(([file, bytes]) => ({
        file,
        sha256: createHash("sha256").update(bytes).digest("hex"),
      })),
    },
    null,
    2,
  ) + "\n",
);
for (const [name, bytes] of outputs) {
  const url = new URL(name, root);
  if (process.argv.includes("--check"))
    assert.deepEqual(await readFile(url), Buffer.from(bytes), `Regenerate ${name}`);
  else {
    await mkdir(new URL(".", url), { recursive: true });
    await writeFile(url, bytes);
  }
}
console.log(
  `${process.argv.includes("--check") ? "Verified" : "Generated"} ${outputs.size} native brand and fixture files from @origin89/brand ${version}.`,
);
