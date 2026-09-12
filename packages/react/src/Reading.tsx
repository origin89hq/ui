import { describeReading, type ReadingValue } from "./reading-state.js";
export function Reading({ label, reading }: { label: string; reading: ReadingValue }) {
  return (
    <div className="o89-reading" data-state={reading.state}>
      <span className="o89-reading-label">{label}</span>
      <strong>{describeReading(reading)}</strong>
    </div>
  );
}
