#!/usr/bin/env bash
# pass open - Password Store Extension (https://www.passwordstore.org/)
#
# MIT License
#
# Copyright (c) 2017 Norman "Doug" Douglass
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

cmd_open_usage() {
	cat <<-_EOF
	Usage:
	$PROGRAM open [options] pass-name
	    Open a site that requires authentication.
	    
            Expects a line in the password file beginning with "url:" just like
	    the passff browser plugin.
	    
            Automatically copies the password (first line) to the clipboard.

	    Prints out the url and login name.
	_EOF
	exit 0
}

cmd_open() {
	local path="$@"
	check_sneaky_paths "$path"
	printf "\e[1m\e[37mOpening site \e[4m%s\e[0m\n" "$path"
	local pass="" login="" url=""
	while IFS= read -r line; do
		if [[ -z "$pass" ]] ; then pass="$line"; fi
		if [[ "$line" =~ ^login: ]] ; then login="${line#login:}"; fi
		if [[ "$line" =~ ^url: ]] ; then url="${line#url:}"; fi
	done <<< "$(cmd_show "$path")"

	clip "$pass" "$path"
	echo "url:   $url"
	echo "login: $login"

	local opencmd="xdg-open"
	case "`uname`" in
		Darwin*) opencmd="open";;
	esac
	$opencmd $url > /dev/null 2>&1 

}

[[ "$1" == "help" || "$1" == "--help" || "$1" == "-h" ]] && cmd_update_usage
cmd_open "$@"
