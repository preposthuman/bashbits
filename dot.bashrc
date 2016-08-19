#-------------------------------------------------------------
# Source global definitions (if any)
#-------------------------------------------------------------


if [ -f /etc/bashrc ]; then
    source /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

# Check file exists before sourcing it
function fn_source_file() {
    if [[ -f "$1" ]]; then source "$1" ; fi
}
# Source the files within named folders
function fn_source_contents() {
    for ZZZ in "$@" ; do
        if [[ -d "$ZZZ" ]]; then
            for YYY in $( find "$ZZZ" -type f ) ; do
                fn_source_file "$YYY"
            done
        fi
    done
}
# Enable bash completion in interactive shells
if ! shopt -oq posix; then
    # This works even on Linux, since $(brew --prefix) returns null string there
    fn_source_file $(brew --prefix)/etc/bash_completion
fi
# Source user-specific bash-completion files and dirs
fn_source_contents ~/.bash-completion ~/.bashrc.d

# Aliases
case $(uname -s) in
    ( Darwin ) alias ls='ls -hFG' ;;
    ( Linux )  alias ls='ls -hF --color' ;;
esac
alias ll='ls -Al'
alias l.='ls -d .*'        # Show hidden files
alias lx='ls -lXB'         # Sort by extension
alias lk='ls -lSr'         # Sort by size, biggest last
alias lt='ls -ltr'         # Sort by date, most recent last
alias lc='ls -ltcr'        # Sort by/show change time, most recent last
alias lu='ls -ltur'        # Sort by/show access time, most recent last
alias lm='ll |more'        # Pipe through 'more'
alias lr='ll -R'           # Recursive ls
alias tree='tree -Csuh'    # Nice alternative to 'recursive ls'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'
# Start bc with math support
alias bc='bc --mathlib'
# Colorize diff output
which colordiff >/dev/null && alias diff='colordiff'
# Resume wget by default
alias wget='wget -c'
# Sane defaults for 'file'
alias file='file --preserve-date --uncompress'
# Save that one repetitive annoyance
alias ..='cd ..'
# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
# More legible output for du and df
alias du='du -kh'
alias df='df -kTh'

# Now we construct the prompt.
export PROMPT_DIRTRIM=6
PROMPT_COMMAND="history -a"
