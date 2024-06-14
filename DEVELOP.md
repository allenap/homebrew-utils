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
- Merge the PR **by setting the _pr-pull_ label**.
  - This ^^^^ bit is important, because it triggers the release workflow which
    inserts/updates the `bottle` stanzas in the formulas.

Your branch will be deleted.

That's all; that should be it.
