# Releasing @origin89/ui-react

Use Changesets to collect reviewed release notes and explicit version bumps. Each feature PR that affects consumers includes a note from `pnpm changeset`. Docs, tests and internal tooling changes that do not affect the package need no release note.

The `publish-react.yml` workflow runs on `main` pushes and can be run manually on `main`. With pending changesets it opens or updates `changeset-release/main`, applying versions, updating the lockfile and generating `packages/react/CHANGELOG.md`. Merging that release PR lets the workflow build, validate, pack and publish the released version through npm OIDC. GitHub release notes come from the changelog. Do not push release tags manually. This workflow accepts stable versions only; prereleases are rejected before a publish plan is created.

## Package and commands

Only `@origin89/ui-react` in `packages/react` is published. The root and application packages are private. `pnpm release:version` applies pending notes, refreshes the lockfile and runs `pnpm check`. `pnpm run package` prepares the complete distribution before Changesets packs it. `pnpm release:publish` is the Changesets publish command; CI supplies its prepared tarballs.

`pnpm check` validates generated brand values, builds the React library and runs its tests. The release also requires Swift tests, an iOS Simulator build, and Android checks/builds. Generated brand files are checked for drift; package JavaScript and declarations are ignored outputs. Swift package tags and Android distribution are independent of this npm release workflow.

## npm and GitHub setup

The npm trusted publisher is GitHub organization `origin89hq`, repository `ui`, workflow `publish-react.yml`, with no environment and direct publishing enabled. Only the publish job has OIDC permission; no npm token is stored in GitHub. Actions must be allowed to create pull requests.

Release PRs created using `GITHUB_TOKEN` create approval-gated PR workflows. Review the release diff, approve the pending `Checks` workflow on the PR, and verify all required checks before merging. A separate manual branch run does not clear that approval gate. An organization GitHub App token can automate this later without changing npm authentication.

The existing `v0.1.0` GitHub release and npm `0.0.0` bootstrap remain intact. The initial patch note produces `0.1.1`, preserving the already released `0.1.0` version. New workspace release tags use `@origin89/ui-react@<version>`. npm tarballs include the changelog. No extra binary or archive assets are attached to new GitHub releases.

## Recovery

Fix a failed build in a PR. If npm rejects authentication, correct its trusted-publisher settings and rerun the failed publish job using the same prepared artifacts. If npm publication succeeded but the Git tag or GitHub release failed, restore only those missing records at the original release commit using its changelog. Never replace a published version or move an existing release tag.

References: [Changesets automation](https://changesets.dev/guide/automating) and [npm trusted publishing](https://docs.npmjs.com/trusted-publishers/).
