#!/usr/bin/env bash
set -e
# for step by step debug uncomment the below 2 lines:
# set -x
# trap read debug
source installer.bash

# set defaults
export DEBUG=0 # to turn on, set DEBUG=1, more printing happens
export REQUIRED=0
LOCAL_PATH="${HOME}"
SCRIPT_PATH="${HOME}/.irssi/scripts"


usage(){
    local long="${1}"
    cat << _EOF1_
ABOUT
    installs the irssi configuration to show notifications on gnome desktop.

USAGE
    ${0} [options]

OPTIONS:
    --locpath   - user writeable path where "bin" folder will be used to put files
                [default: ${LOCAL_PATH}]
    --scripts   - irssi scripts folder
                [default: ${SCRIPT_PATH}]

_EOF1_

    if [[ -z "${long}" ]]; then
        return
    fi
    cat << _EOF2_
EXAMPLES:
    1. Using all the defaults:
    ${0}

    2. Passing only selection of parameters:
    ${0} \\
        --locpath="\$HOME/local"

    3. Passing ALL params:
    ${0} \\
        --locpath="\$HOME/local" \\
        --scripts="\$HOME/.irssi/plugins/scripts"

_EOF2_

}


get_opts(){
    local \
        long \
        short
    local args=""
    local options_arr=(
        "locpath"
        "scripts"
        "help"
    )
    REQUIRED=0
    long=$( installer.generate_long_opts "${options_arr[@]}" )
    short=$( installer.generate_short_opts "${options_arr[@]}" )
    args="$( getopt -o "${short}" -l "${long}" -n "$0" -- "$@" )"
    eval set -- "$args";
    while true; do
        case "$1" in
            -l|--locpath)
                shift; LOCAL_PATH="${1}"; shift;
                ;;
            -s|--scripts)
                shift; SCRIPT_PATH="${1}"; shift;
                ;;
            -h)
                usage; installer.die 0 "";
                ;;
            --help)
                usage "long"; installer.die 0 "";
                ;;
            --)
                shift; break;
                ;;
                # end of options
        esac
    done
}


main(){
    local required_apps
    required_apps=(
        "pgrep"
        "xargs"
        "canberra-gtk-play"
    )
    installer.check_required_apps "${required_apps[@]}"
    get_opts "${@}"

    installer.run_installer \
        "${LOCAL_PATH}/bin/irssi-notifier.sh" \
        "${LOCAL_PATH}/bin/notify-listener.py" \
        "${SCRIPT_PATH}/notify.pl"
}


if ! [[ "$0" =~ /bash$ ]]; then
    main "${@}"
fi
