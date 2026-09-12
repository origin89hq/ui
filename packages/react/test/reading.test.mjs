import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";
import { createElement } from "react";
import { renderToStaticMarkup } from "react-dom/server";
import { describeReading, EquipmentIllustration, Reading } from "../dist/index.js";

const fixtures = JSON.parse(
  await readFile(new URL("../../../fixtures/readings.json", import.meta.url), "utf8"),
);
for (const fixture of fixtures)
  test(fixture.expected, () => {
    assert.equal(describeReading(fixture.reading), fixture.expected);
    assert.ok(renderToStaticMarkup(createElement(Reading, fixture)).includes(fixture.expected));
  });
test("invalid numeric readings stay unknown", () => {
  for (const value of [NaN, Infinity, -Infinity])
    assert.equal(describeReading({ state: "current", value, unit: "W" }), "Unknown");
});
test("equipment drawings remain decorative", () => {
  for (const kind of ["solar", "generator", "cottage", "battery", "mining", "telecom"])
    assert.match(
      renderToStaticMarkup(createElement(EquipmentIllustration, { kind })),
      /aria-hidden="true"/,
    );
});
