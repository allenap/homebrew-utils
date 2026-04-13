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
- Merge the PR.
  - The release workflow runs automatically when the PR is merged, inserting
    and updating the `bottle` stanzas in the formulas.
  - Alternatively, applying the _pr-pull_ label to the PR triggers the same
    release workflow before merging (useful when you want to preview the result,
    though note that the branch is then deleted by the workflow rather than by
    GitHub at merge time).

Your branch will be deleted.

That's all; that should be it.

### Recovery: if the release workflow didn't run

If the release workflow didn't run for a merged PR (e.g. it failed or was
skipped), you can trigger it manually:

1. Go to **Actions → brew pr-pull → Run workflow**.
2. Enter the PR number and click **Run workflow**.

This re-runs `brew pr-pull` for the specified PR, which pulls any already-built
bottle artifacts and pushes the updated formula to `master`.
