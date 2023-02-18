### mash -  a make-ish bash script
_______

A simple bash task runner to avoid makefiles. Nothing fancy.

Define functions in bash with the name `run:x` and then execute with `./mash x`

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

### Setup

The `mash` scripts header and footer can be printed with the `dump` task to initialize a new file

    $ ~/repos/make.sh/mash dump > ~/myrepo/mash
    $ chmod 755 my/mash

List commands

    $ ./mash

 or

    $ ./mash help
    Commands:
      task:name
      other

The default `dump` task includes a shell completion helper

    $ ./mash completion:words
    task:name
    other

For zsh completions add a `_mash` file in `$fpath`

```
#compdef mash

local context state state_descr line
tasks=( $(_call_program completion:words $words[1] completion:words) )
_arguments "1:task:($tasks)" \
           "*:arg:->args"
```

### `sh` or `bash`

POSIX `sh` doesn't guarentee a function named with a `:` works, even though it does work for most
 implementations. `bash` also allows for much simpler `${var:1:2}` substring indexing.

MIT license

