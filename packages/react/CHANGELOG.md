# @origin89/ui-react

## 0.1.2

### Patch Changes

- 8976f73: Read colour from tokens the brand package actually defines, and move to `@origin89/brand` 0.4.0.
  
  `styles.css` referenced `--color-bg` in six declarations. The palette deliberately has no such token — the page colour is `--color-page` — so the equipment drawing's fill, its line colour and three derived `color-mix()` values resolved to nothing and fell back to inherited paint. A test now fails if the stylesheet reads a token the installed brand package does not define, or carries a colour literal of its own.

## 0.1.1

### Patch Changes

- 5d51d43: Make the React components, equipment illustrations, styles and TypeScript declarations available through npm with release notes and build provenance.

## 0.1.0

Initial GitHub release of React readings, equipment illustrations, CSS and TypeScript declarations.
