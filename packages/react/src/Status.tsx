import type { ReactNode } from "react";

/**
 * A state chip.
 *
 * The tone is the presentation, not the meaning: what counts as an alarm belongs to the
 * application, which maps its own vocabulary onto these. Each tone pairs its hue with a border
 * style and a mark, so the chip still reads where colour does not arrive.
 */
export type StatusTone = "nominal" | "alarm" | "warning" | "info" | "faint";

const MARK: Record<StatusTone, string> = {
  nominal: "\u2713",
  alarm: "!",
  warning: "\u2022",
  info: "\u2022",
  faint: "\u2022",
};

export function Status({ tone = "faint", children }: { tone?: StatusTone; children: ReactNode }) {
  return (
    <span className="o89-status" data-tone={tone}>
      <span aria-hidden="true">{MARK[tone]}</span>
      {children}
    </span>
  );
}
