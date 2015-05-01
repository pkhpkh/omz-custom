source `dirname $_`/xlfm.zsh

function journal_viewer {
    ~/src/xl/Tools/journal_viewer/journal_viewer.py $*
}

alias jv=journal_viewer


function strip_snapshot {
    tail -c +97 $1 > stripped_$1
}

function extract_journals {
    tail -c +97 $1 | tail -c 16M > journals_$1
}

set_xl_target() {
    echo $1 > ~/.xl_target
    export XL_IP=$1
}

alias xltarget=set_xl_target

# main()
#
if [[ -r ~/.xl_target ]] then
    set_xl_target `cat ~/.xl_target`
else
    set_xl_target localhost
fi

function __xl_get_target {
    TARGET=$1
    if [[ "$TARGET" = "" ]] then
        TARGET=$XL_IP
    fi
    echo $TARGET    
}

function nav_clear {
    TARGET=`__xl_get_target $1`
    curl -X DELETE -w"\n" http://$TARGET/rest/files/user-stf/hierarchy.json\?sid=session=7de6dd7cf3d5ffd43c2ea7aec26c81f9\&user=Administrator\&digest=e49da2e0d43611d0b2c62c1aed36e3fedac0b4ea
}

function clear_xl_path {
    curl -X DELETE -w"\n" $1\?sid=session=7de6dd7cf3d5ffd43c2ea7aec26c81f9\&user=Administrator\&digest=e49da2e0d43611d0b2c62c1aed36e3fedac0b4ea
}

function scurl {
    curl $1\?sid=session=7de6dd7cf3d5ffd43c2ea7aec26c81f9\&user=Administrator\&digest=384ca1a1117f0bffcc9bb237332af620457865b6 $2 $3 $4 $5 $6 $7 $8 $9
}

function xl_timeversion {
    echo 2.0.0.`date +%m%d-%H%M`
}

function xl_ps {
    USAGE='xl_ps <get|set|unset> <address> <process_state> <reason?>'

    if [[ $2 = "" ]] then
        echo Insufficient parameters
        echo $USAGE
        return 1
    fi

    if [[ $1 = "get" ]] then
        PAYLOAD=""
    elif [[ $1 = "unset" ]] then
        PAYLOAD="-d { \"enabled\": false }"
    elif [[ $1 = "set" ]] then
        PAYLOAD="-d { \"enabled\": true, \"reason\": \"$4\" }"
        if [[ $4 = "" ]] then
            echo No reason
            echo $USAGE
            return 1
        fi
    else
        echo No command
        echo $USAGE
        return 2
    fi


    curl -H "Content-Type: application/json" $2/rest/v1/aspect/process-state/details/$3 $PAYLOAD
}
