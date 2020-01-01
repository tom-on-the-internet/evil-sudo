# Evil Sudo

Like `sudo`, but _evil_.

Your coworker walks away from their desk and forgets to lock their computer. Big mistake. Copy and paste the command below into the terminal. Walk away. Now, when they try to use `sudo` they will get a confusing error message which you can customize.

Evil Sudo is just for fun and does no damage to the computer.

## Usage

### Standard

All sudo commands will spit out a confusing error message.

`curl files.tomontheinternet.com/evil-sudo.sh | sh`

### Custom Error Message

All sudo commands will spit out a confusing error message of your choosing.

`curl files.tomontheinternet.com/evil-sudo.sh | sh -s -- "a custom error message"`

### Clean Up

Evil sudo is removed.

`curl files.tomontheinternet.com/evil-sudo.sh | sh -s -- -c`

## Why

1. I wanted to practice my shell scripting.
2. It's a funny trick.
3. A useful reminder to never leave your computer unlocked.

## How

`evil-sudo.sh` adds a directory to your `$PATH` and then creates a fake sudo program in that directory. It does this by determining what shell you are using, and adding a line to your `rc` file. So far, it only supports bash and zsh, but that covers 95% of all users. Now, when you run the `sudo` command, your shell finds the fake sudo program first and uses the fake sudo instead of the real sudo.

Evil Sudo does not modify the `sudo` program at all. It can't because it's not run as root.
