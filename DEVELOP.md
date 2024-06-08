# Working on the formulae in this tap

- [How to Create and Maintain a Tap](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [RubyDoc `Formula`](https://rubydoc.brew.sh/Formula)

## Example: creating the `withd` formula

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

Later:

```bash
# `livecheck` knows how to find newer versions on GitHub, for example.
brew livecheck --tap allenap/utils withd
```
