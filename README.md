# slg

[![Gem Version](https://img.shields.io/gem/v/slg.png)](http://badge.fury.io/rb/slg)
[![Coverage Status](https://img.shields.io/coveralls/bfontaine/slg.svg)](https://coveralls.io/r/bfontaine/slg)
[![Inline docs](http://inch-ci.org/github/bfontaine/slg.svg)](http://inch-ci.org/github/bfontaine/slg)

**slg** is a command-line tool for [Slengo][], the Italian Urban Dictionary.

See [ud][] for the English equivalent.

[Slengo]: https://slengo.it/define/catramina

## Example

    $ slg zisca
    * zisca (100/0):

        Sigaretta.

    Example:
        Oh, amo' che mi alzi una zisca?

## Install

    gem install slg

Windows users: You will need the Win32 Console ANSI gem for the colored output.
Install it with `gem install win32console`.

## Usage

From the command-line:

    $ slg <word>

It supports a few options:

- `-n`, `--count`: maximum number of definitions (default: 1)
- `--no-color`: disable colored output.
- `-b`, `--browser`: open the results in your browser instead of displaying
  them in the console

In a Ruby script:

```ruby
require "slg"

defs = Slg.query("wtf")
```
