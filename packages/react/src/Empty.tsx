import type { ReactNode } from "react";

/** Absence, said plainly. The mark is the caller's, so the package carries no icon set. */
export function Empty({
  title,
  mark,
  children,
}: {
  title: string;
  mark?: ReactNode;
  children: ReactNode;
}) {
  return (
    <div className="o89-empty">
      {mark ? (
        <span className="o89-empty-mark" aria-hidden="true">
          {mark}
        </span>
      ) : null}
      <h3>{title}</h3>
      <p>{children}</p>
    </div>
  );
}
