makesh
_______

A simple shell task manager to avoid `make`. Define functions in bash with the name `run:x` and run

```
run:task:name () {
  echo "I am name"
}
```

    ./make.sh task:name  #runs `run:task:name`


List commands

    ./make.sh
    # or
    ./make.sh help

MIT license

