# Some common functions that I seem to recreate at every job

die() {
    # Function to die with message and exit code
    cd "$( dirs -0 )" && dirs -c
    echo "$1" >&2
    echo "Exiting with exit code (${2:-1})" >&2
    exit ${2:-1}
}
dprint() {
    local -r DT=$( date +%F_%T )
    echo "$DT: ${FUNCNAME[1]}: $*" >&1
}
dump_vars() {
    local -r DT=$( date +%F_%T )
    for ZZZ in $* ; do
        echo "$DT: dump_vars: $ZZZ='${!ZZZ}'" >&1
    done
}
func_start() {
    local -r DT=$( date +%F_%T )
    echo "$DT: Starting ${FUNCNAME[1]}" >&1
}
func_end() {
    local -r DT=$( date +%F_%T )
    echo "$DT: Finished ${FUNCNAME[1]}" >&1
}

