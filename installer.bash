#!/usr/bin/env bash
#set -x
#set -e

#DEBUG=0 # to turn on, set DEBUG=1, more printing happens
# for step by step debug uncomment the below 2 lines:
# set -x
# trap read debug
# set defaults
LOCAL_PATH="${HOME}"
SCRIPT_PATH="${HOME}/.irssi/scripts"
REQUIRED=0

installer.log_info(){
    local message_str="${*}"
    [[ -n "${message_str}" ]] || return 0
    echo \
        -en "INFO: ${message_str}"
    echo
    return 0
}


installer.log_debug(){
    local message_str="${*}"
    if [[ "${DEBUG}" -eq 0 ]]; then
        return 0
    fi
    [[ -n "${message_str}" ]] || return 0
    echo \
        -en "DEBUG: ${message_str}"
    echo
    return 0
}


installer.log_error(){
    local message_str="${*}"
    [[ -n "${message_str}" ]] || return 0
    echo \
        -e "ERROR: ${message_str}" \
    > /dev/stderr
    return $?
}


installer.die(){
    local return_code="${1:-1}"
    local message_str="${*:2}"
    installer.log_error "${message_str}"
    exit "${return_code}"
}


installer.check_required_apps(){
    # verify required apps are present
    local \
        apps \
        app
    apps=("${@}")
    installer.log_debug "in installer.check_required_apps(${apps[*]})"
    for app in "${apps[@]}"; do
        type \
            "${app}" \
        &> /dev/null
        [[ 0 -eq $? ]] \
        || installer.die $? "$0 failed: no ${app} on PATH, please install."
    done
}


installer.generate_long_opts(){
    # prepares long options for getopts
    local \
        options_arr \
        option \
        result

    options_arr=("${@}")
    result=""
    for option in "${options_arr[@]}"; do
        [[ -z "${result}" ]] || result+=","
        result+="${option}"
        result+=":"
        if [[ "${REQUIRED}" -eq 0 ]]; then
            result+=":"
        fi
    done
    echo "${result}"
    return 0    
}


installer.generate_short_opts(){
    # prepare short options for getopts
    local \
        options_arr \
        option \
        result

    options_arr=("${@}")
    result=""
    for option in "${options_arr[@]}"; do
        result+="${option:0:1}"
        result+=":"
        if [[ "$REQUIRED" -eq 0 ]]; then
            result+=":"
        fi
    done
    echo "${result}"
    return 0
}


installer.make_desktop_entry(){
    local \
        apppath \
        dest_path \
        base_path \
        desktop_entry_path
    installer.log_debug "in installer.make_desktop_entry(${*})"
    apppath="${1}"
    dest_path="${2:-"$HOME/.config/autostart"}"
    [[ -n "${apppath}" ]] \
    || installer.die $? "first param cannot be empty: '${apppath}'"
    base_path="${apppath##*/}"
    installer.log_debug "base_path=$base_path"
    desktop_entry_path="${dest_path}/${base_path%.*}.desktop"
    installer.log_debug "desktop_entry_path=$desktop_entry_path"
    mkdir -p "${dest_path}"

    cat > "${desktop_entry_path}" << _EOF3_
#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Type=Application
Name=${base_path}
Comment=Launcher for ${base_path}
TryExec=${apppath}
Exec=${apppath} %F

_EOF3_
    chmod +x "${desktop_entry_path}"
    installer.log_debug "Created desktop entry: ${desktop_entry_path}"
    return 0
}

installer.install_files(){
    local \
        targets \
        target \
        base \
        folder
    targets=("${@}")
    installer.log_debug "=> installer.install_files(${targets[*]})"
    for target in "${targets[@]}";  do
        base="${target##*/}"
        folder="${target%/*}"
        [[ -d "${folder}" ]] \
        || installer.die $? "${folder} is not a directory"
        cmd=(
            "install"
            "--verbose"
            "-D"
            "-m" "0755"
            "./${base}"
            "${target}"
        )
        installer.log_debug "Running command: '${cmd[*]}'"
        "${cmd[@]}"
    done
}

installer.run_installer(){
    local \
        scripts
    scripts=("${@}")
    installer.log_debug "in installer.run_install(${scripts[*]})"
    [[ "${#scripts[@]}" -gt 1 ]] \
    || installer.die $? "argument must contain at least 2 elements"
    installer.install_files "${scripts[@]}"
    installer.make_desktop_entry \
        "${scripts[1]}" \
        "$HOME/.config/autostart"
}
