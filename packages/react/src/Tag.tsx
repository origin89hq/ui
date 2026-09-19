import type { ReactNode } from "react";

/** A small technical label. It withdraws on a narrow window, where the room is better spent. */
export function Tag({ children }: { children: ReactNode }) {
  return <span className="o89-tag">{children}</span>;
}
