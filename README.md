mash - makish bash
_______

A simple bash task runner to avoid makefiles. Define functions in bash with the name `run:x` and run

```
run:task:name () {
  echo "I am name"
}
run:other(){
  printf "I'm %s\n" "$*"
}
```

    $ ./mash task:name  #runs `run:task:name`
    I am name

    $ ./mash other a bunch of things  #runs `run:other`
    I'm a bunch of things

    $ ./mash completion:words
    task:name
    other

List commands

    $ ./mash
    # or
    $ ./mash help
    Commands:
      task:name
      other

MIT license

