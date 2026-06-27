# Working on the formulae in this tap

- [How to Create and Maintain a Tap](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [RubyDoc `Formula`](https://rubydoc.brew.sh/Formula)

## Example: `withd`

### Creating the formula

```bash
# Create the formula.
brew create --rust --tap allenap/utils https://github.com/allenap/withd/archive/refs/tags/v0.2.3.tar.gz
# Check that it installs okay.
brew install allenap/utils/withd
# Run the tests in the formula.
brew test allenap/utils/withd
# Test for adherence to Homebrew house style.
brew audit --new --strict --online --tap allenap/utils withd
```

### Checking in later on

```bash
# `livecheck` knows how to find newer versions on GitHub, for example.
brew livecheck --tap allenap/utils withd
```

### Updating the formula

There may be a better way to do this, a more automated way, but this works.

Get the new source code tarball URL and plug it in here:

```bash
curl --location https://github.com/allenap/withd/archive/refs/tags/v0.3.1.tar.gz \
    | shasum -a 256 -b | cut -swf 1 | pbcopy
```

The new SHA-256 checksum is now in your clipboard. Next:

- Update the `url` and `sha256` fields in the formula.
- Commit the changes, push the branch, and open a new PR.
- Wait for CI to pass – or, at least, yield errors that you can fix or ignore.
- Merging and bottle publishing are automatic for version bumps:
  - **Automated bumps** opened by the `livecheck` workflow use a `bump-*`
    branch. Once CI passes, the release workflow pulls the freshly-built bottles,
    inserts/updates the `bottle` stanzas, pushes to `master`, closes the PR, and
    deletes the branch. There is nothing to remember and no label to set.
  - **Manual bumps**: name your branch `bump-<formula>-<version>` to get the same
    automatic handling, or apply the _pr-pull_ label to the PR to trigger the
    release workflow before merging.

That's all; that should be it.

### Recovery: if bottles didn't get published

If a PR was merged without the release workflow running – e.g. it was merged with
the button on a branch not named `bump-*` – the bottles may have been built but
never pushed to ghcr, and `brew install` will then 404 on the missing bottle. To
recover:

1. Go to **Actions → brew pr-pull → Run workflow**.
2. Enter the PR number and click **Run workflow**.

This re-runs `brew pr-pull` for that PR, pulling the already-built bottle
artifacts (CI keeps them for 90 days) and pushing the updated formula to
`master`.
