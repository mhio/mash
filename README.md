make.sh
_______

A simple bash task runner to avoid `make`. Define functions in bash with the name `run:x` and run

```
run:task:name () {
  echo "I am name"
}
```

    $ ./make.sh task:name  #runs `run:task:name`
    I am name


List commands

    ./make.sh
    # or
    ./make.sh help
    Commands:
      task:name

MIT license

