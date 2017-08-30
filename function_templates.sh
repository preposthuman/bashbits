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
        if [[ "$(declare -p $ZZZ)" =~ "declare -a" ]]; then
            echo "$DT: dump_vars: $ZZZ='${!ZZZ[@]}'" >&1
        else
            echo "$DT: dump_vars: $ZZZ='${!ZZZ}'" >&1
        fi
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
function check_execs() {
    # First, check any short names
    local -r SHORT=$( which "$1" 2>/dev/null )
    if [[ -n "$SHORT" ]] && [[ -x "$SHORT" ]]; then
        return
    fi
    # Else, die with error
    die "Cannot find executable '$1' or file is not set to executable!" ${2:-99}
}
