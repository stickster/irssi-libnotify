#!/usr/bin/env bats

load installer

@test "Test: installer.log_info()" {
	local \
		msg \
		expected
	msg=""
	expected=""
	run installer.log_info "${msg}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" = "${output}" ]]

    msg="kuku"
    expected="INFO: ${msg}"
	run installer.log_info "${msg}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" = "${output}" ]]

    msg="kuku\qoiqoi"
    expected="INFO: ${msg}"
	run installer.log_info "${msg}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" = "${output}" ]]

}


@test "Test: installer.log_debug()" {
	local \
		msg \
		expected
	msg=""
	expected=""
	DEBUG=1
	run installer.log_debug "${msg}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" = "${output}" ]]

    msg="kuku"
    expected="DEBUG: ${msg}"    
	run installer.log_debug "${msg}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" = "${output}" ]]

    msg="kuku\qoiqoi"
    expected="DEBUG: ${msg}"
	run installer.log_debug "${msg}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" = "${output}" ]]
	DEBUG=0
    msg="kuku"
    expected=""    
	run installer.log_debug "${msg}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" = "${output}" ]]
}



@test "Test: installer.log_error()" {
	local \
		msg \
		expected
	msg=""
	expected=""
	DEBUG=1
	run installer.log_error "${msg}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" = "${output}" ]]

    msg="kuku"
    expected="ERROR: ${msg}"    
	run installer.log_error "${msg}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" = "${output}" ]]

    msg="kuku\qoiqoi"
    expected="ERROR: ${msg}"
	run installer.log_error "${msg}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" = "${output}" ]]
}


@test "Test: installer.check_required_apps()" {
	local \
		app \
		expected
	app="whoami"
	expected=""
	run installer.check_required_apps "${app}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" = "${output}" ]]

    app="ejeje"
	expected="ERROR: $0 failed: no ${app} on PATH, please install."
	run installer.check_required_apps "${app}"
    [[ 1 -eq "${status}" ]]
    [[ "${output}" =~ ${expected}.*$ ]]
}


@test "Test: installer.generate_long_opts()" {
	local \
		opts \
		expected
	opts=("kuku" "ququ")
	REQUIRED=0
	expected="kuku::,ququ::"
	run installer.generate_long_opts "${opts[@]}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" == "${output}" ]]

	REQUIRED=1
	expected="kuku:,ququ:"
	run installer.generate_long_opts "${opts[@]}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" = "${output}" ]]
}


@test "Test: installer.generate_short_opts()" {
	local \
		opts \
		expected
	opts=("kuku" "ququ")
	REQUIRED=0
	expected="k::q::"
	run installer.generate_short_opts "${opts[@]}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" == "${output}" ]]

	REQUIRED=1
	expected="k:q:"
	run installer.generate_short_opts "${opts[@]}"
    [[ 0 -eq "${status}" ]]
    [[ "${expected}" = "${output}" ]]
}

