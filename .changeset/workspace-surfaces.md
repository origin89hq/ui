---
"@origin89/ui-react": minor
---

Add the workspace surfaces: `Tag`, `Status`, `Notice`, `Empty`, `Panel` and `Loading`.

These come from the data site's operations workspace, where they were Tailwind class strings. Here they are plain CSS on brand tokens, so a consumer needs no particular build. `Status` and `Notice` take a tone rather than a domain value, because what counts as an alarm belongs to the application; `Empty` takes its mark as a node, so the package carries no icon set.
