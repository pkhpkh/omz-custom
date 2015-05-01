
run_pyapp() {
    if [[ "$1" = "" ]]
    then
        echo 'Need to supply a program (e.g. xlfm, xlpc)'
    else
        PROGRAM=run_$1_version
        RUN_VERSION=$2

        if [[ "$RUN_VERSION" = "" ]]
        then
            RUN_VERSION=master
        fi

        RUN_VERSION=$RUN_VERSION $PROGRAM $3 $4 $5 $6 $7 $8 $9
    fi
}

run_xlfm () {
    run_pyapp xlfm $*
}

run_xlpc () {
    run_pyapp xlpc $*
}

