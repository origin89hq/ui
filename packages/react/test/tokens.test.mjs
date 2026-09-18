import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { createRequire } from "node:module";
import test from "node:test";

// The stylesheet reads colour from the brand package and defines none of its own. Nothing checked
// that the names it reads exist there, so `--color-bg` — a token the palette deliberately never
// had, because Tailwind would spell its utility `bg-bg` — survived in six declarations, where it
// left the equipment drawing's fill and stroke unresolved.
const require = createRequire(import.meta.url);
const styles = await readFile(new URL("../src/styles.css", import.meta.url), "utf8");
const themes = await readFile(require.resolve("@origin89/brand/tokens/themes.css"), "utf8");

const read = [...styles.matchAll(/var\((--color-[a-z0-9-]+)/g)].map((m) => m[1]);
const defined = new Set([...themes.matchAll(/(--color-[a-z0-9-]+)\s*:/g)].map((m) => m[1]));

test("every brand token the stylesheet reads is one the brand package defines", () => {
  assert.ok(read.length > 0, "expected the stylesheet to read brand tokens");
  const missing = [...new Set(read)].filter((token) => !defined.has(token)).sort();
  assert.deepEqual(missing, [], `not defined by @origin89/brand: ${missing.join(", ")}`);
});

test("the stylesheet carries no colour of its own", () => {
  const literals = styles.match(/#[0-9a-fA-F]{3,8}\b|\brgba?\(|\bhsla?\(/g) ?? [];
  assert.deepEqual(literals, [], `colour belongs in @origin89/brand: ${literals.join(", ")}`);
});
