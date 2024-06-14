# Allenap's utilities for HomeBrew

Compromising things I've written that I personally find useful, packaged for
installation using [HomeBrew](https://brew.sh), including:

- [rust-petname](https://github.com/allenap/rust-petname): Generate human
  readable random names.

- [withd](https://github.com/allenap/withd): A simple utility for running
  commands with a modified working directory.

- [unison-confgen](https://github.com/allenap/unison-confgen): This helps me
  generate my [Unison](https://github.com/bcpierce00/unison) configuration
  files.

## How do I install these formulae?

`brew install allenap/utils/<formula>`

Or `brew tap allenap/utils` and then `brew install <formula>`.

Or, in a [`brew bundle`](https://github.com/Homebrew/homebrew-bundle) `Brewfile`:

```ruby
tap "allenap/utils"
brew "<formula>"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
