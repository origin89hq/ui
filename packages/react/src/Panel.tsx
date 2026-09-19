import type { ReactNode } from "react";

/** A surface that holds one thing, wearing the plate's clipped corner. */
export function Panel({ children }: { children: ReactNode }) {
  return <section className="o89-panel">{children}</section>;
}
