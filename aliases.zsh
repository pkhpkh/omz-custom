function vm {
    (cd ~/src/vm && vagrant $*)
}

function rally {
    python ~/src/build-internal/pylib/rally/rally $*
}
