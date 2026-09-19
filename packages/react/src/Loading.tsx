/**
 * Work in progress.
 *
 * The bars are the shape of what is coming rather than a bare spinner, and both the spinner and
 * the bars stop under a reduced-motion preference.
 */
export function Loading({ label = "Loading\u2026" }: { label?: string }) {
  return (
    <div className="o89-loading">
      <p role="status">
        <span className="o89-loading-spinner" aria-hidden="true" />
        {label}
      </p>
      <div aria-hidden="true">
        {[0, 1, 2, 3].map((bar) => (
          <span className="o89-loading-bar" key={bar} />
        ))}
      </div>
    </div>
  );
}
