### mash

A simple make-ish task runner in bash to avoid makefiles. Nothing fancy.

_______

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

Or all in one
    
    ./mash dump:to ~/myrepo/mash

### Tasks

List tasks

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

bash completion `/etc/bash_completion.d/mash`
```
_mash()
{
  #pwd
  #echo "0:$0 1:$1"
  _script_commands=$($1 completion:words)

  local cur
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${_script_commands}" -- ${cur}) )

  return 0
}
# no space after
#complete -o nospace -F _mash ./mash.sh
complete -F _mash mash
```


### `sh` or `bash`

POSIX `sh` doesn't guarentee a function named with a `:` works, even though it does work for most
 implementations. `bash` also allows for much simpler `${var:1:2}` substring indexing.

MIT license

