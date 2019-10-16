# Evil Sudo

Like `sudo`, but *evil*.

Your coworker walks away from their desk and forgets to lock their computer. Big mistake. Copy and paste the command below into the terminal. Walk away. Now, when they try to use `sudo` they will get a confusing error message which you can customize.

Evil Sudo is just for fun and does no damage to the computer.

## Usage

### Standard

All sudo commands will spit out a confusing error message.

`curl https://raw.githubusercontent.com/tom-on-the-internet/evil-sudo/master/evil-sudo.sh | sh`

### Custom Error Message

All sudo commands will spit out a confusing error message of your choosing.

`curl https://raw.githubusercontent.com/tom-on-the-internet/evil-sudo/master/evil-sudo.sh | sh -s -- "a custom error message"`

### Clean Up

Evil sudo is removed.

`curl https://raw.githubusercontent.com/tom-on-the-internet/evil-sudo/master/evil-sudo.sh | sh -s -- -c`

## Why

1. I wanted to practice my shell scripting.
2. It's a funny trick.
3. A useful reminder to never leave your computer unlocked.

## How

Evil Sudo looks for the first directory in the users path to which they have access. Usually this is `~/.local/bin`. When a directory is found, Evil Sudo creates a `sudo` file which spits out an error message. Because this file is earlier in the $PATH than the *real* `sudo` command, it takes precedence.

Evil Sudo does not modify the `sudo` program at all. It can't because it's not run as root.



