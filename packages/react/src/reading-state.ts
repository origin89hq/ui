export type ReadingValue =
  | { state: "current"; value: number; unit: string }
  | { state: "stale"; value: number; unit: string; age: string }
  | { state: "unknown" };
export function describeReading(reading: ReadingValue): string {
  if (reading.state === "unknown") return "Unknown";
  if (!Number.isFinite(reading.value)) return "Unknown";
  const value = `${reading.value} ${reading.unit}`.trim();
  return reading.state === "stale" ? `${value} · Last known · ${reading.age}` : value;
}
