import type { ReactNode } from "react";

/** A line of consequence above the thing it concerns. An alarm announces itself; anything else
 *  is a status, so a screen reader is not interrupted by a note. */
export function Notice({
  tone = "info",
  children,
}: {
  tone?: "info" | "alarm";
  children: ReactNode;
}) {
  return (
    <div className="o89-notice" data-tone={tone} role={tone === "alarm" ? "alert" : "status"}>
      {children}
    </div>
  );
}
