mash - make-ish bash
_______

A simple bash task runner to avoid makefiles. Define functions in bash with the name `run:x` and run

```
run:task:name () {
  echo "I am task:name"
}
run:other(){
  printf "I'm %s\n" "$*"
}
```

    $ ./mash task:name  #runs `run:task:name`
    I am task:name

    $ ./mash other a bunch of things  #runs `run:other`
    I'm a bunch of things

The headers/footer can be printed with `dump`

    $ /path/to/default/mash dump > my/mash
    $ chmod 755 my/mash

List commands

    $ ./mash
    # or
    $ ./mash help
    Commands:
      task:name
      other

The default dump comes with a completion helper

    $ ./mash completion:words
    task:name
    other

zsh completions `_mash` in `$fpath`

```
#compdef mash
# Not this only works in the directory: `./mash`
args=( $(./mash completion:words) )
_arguments '*: :(${args})'
```

POSIX `sh` doesn't guarentee a function with `:` works, even though it does for most implementations so it's bash for the moment

MIT license

