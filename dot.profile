# Set architecture flags
export ARCHFLAGS="-arch $(uname -m)"
# Ensure user-installed binaries take precedence
echo "$PATH" | grep -q '/usr/local/bin:' || export PATH="/usr/local/bin:${PATH}"

# History things
export HISTIGNORE="&:bg:fg:ll:ls:h:history"
export HISTTIMEFORMAT="[%Y-%m-%d_%H:%M:%S] "
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=200000

# Shell options
shopt -s checkwinsize  # check window size after each command and update LINES and COLUMNS.
shopt -s cmdhist
shopt -s expand_aliases
shopt -s extglob       # Necessary for programmable completion.
shopt -s histappend
shopt -s histreedit
shopt -s histverify
shopt -s no_empty_cmd_completion

case $(uname -s) in
    ( Darwin )
        # Check for homebrew, message if not found
        # http://brew.sh
        if ! which -s brew 2>/dev/null >/dev/null || [[ -z "$(brew --prefix)" ]]; then
            echo 'It looks like this mac does not have homebrew.'
            echo 'You can get it from http://brew.sh'
            echo
        fi
        # Folders to ignore in cd tab-completion
        # http://brettterpstra.com/2014/07/12/making-cd-in-bash-a-little-better/
        export FIGNORE="Application Scripts:ScriptingAdditions"

        # If coreutils has been installed
        DIR_TO_CHECK='/usr/local/opt/coreutils/libexec/gnubin'
        if [[ -d "$DIR_TO_CHECK" ]] && echo "$PATH" | grep -qv "$DIR_TO_CHECK:" ; then
            export PATH="$DIR_TO_CHECK:$PATH"
        fi
        DIR_TO_CHECK='/usr/local/opt/coreutils/libexec/gnuman'
        if [[ -d "$DIR_TO_CHECK" ]] && echo "$PATH" | grep -qv "$DIR_TO_CHECK:" ; then
            export PATH="$DIR_TO_CHECK:$PATH"
        fi

        # Setting PATH for Python 3.5
        # The orginal version is saved in .bash_profile.pysave
        DIR_TO_CHECK='/Library/Frameworks/Python.framework/Versions/3.5/bin'
        if [[ -d "$DIR_TO_CHECK" ]] && echo "$PATH" | grep -qv "$DIR_TO_CHECK:" ; then
            export PATH="$DIR_TO_CHECK:$PATH"
        fi
        ;;
    ( Linux )
        shopt -s autocd
        shopt -s globstar
        ;;
esac

# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc
