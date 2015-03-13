# Quick Start #

## Features ##

This script issues notifications on the desktop to let a GUI user know something is going on in an Irssi session.  The following types of messages produce notifications:

  * private message
  * highlighted public message
  * DCC request

## Requirements ##

  * `irssi` (0.8+ ?)
  * `libnotify`
  * `pygobject` >= 3.0
  * `perl-HTML-Parser`
  * _Optional:_ `screen`

Any current [Fedora](http://fedoraproject.org) system will provide the appropriate version of `libnotify`, but you may need to install `irssi` and `perl-HTML-Parser` (and optionally `screen`).  Other modern Linux systems should work just as well.

For Ubuntu, run `apt-get install perl perl-base perl-modules system-tools-backends` so the script will have dependencies needed.

## Download ##

You can download the plugin [here](https://code.google.com/p/irssi-libnotify/source/checkout).

# Details #

## How It Works ##

A lot of people run a permanently-connected Linux box, usually on a broadband connection.  You can run `screen` on that system, which decouples the console from the particular terminal where you logged in.  (Basically, it means you can disconnect the `screen` session, log out, log in later or from somewhere else, and reconnect right back where you left off.)  `screen` gives you multiple windows much like a GUI, although of course it's **much** faster and less resource-intensive, so you can even run it on your home server's 300 MHz CPU.

Think of the power: You run a `screen` session on your permanent system, and `irssi` in a window.  Even if you leave home or work, and want to keep logging or know if someone tried to reach you while you were away, you now have that capability.

Just `ssh` to your desired "permanent" chat box, and run `screen`.  Then you can start `irssi` in a `screen` window.

> | See http://irssi.org/documentation for more on using `screen`.  If you're in `screen`, hit **Ctrl+A ?** to see online help, or `man screen` of course. |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------|

Copy the `notify-listener.py` program and the `irssi-notifier.sh` script to your `$HOME/bin/` folder.  NOTE: If you are running SSH to get to a remote box where you run `screen` and/or `irssi`, you need to put these on your **local** box, and you will also need to set up SSH so that the remote machine can execute `ssh` to your local box without a passphrase.  You can find plenty of tutorials for this on the web, but I find it easiest to use `ssh-copy-id`.

It's a good idea to use `gnome-session-properties`, or whatever controls your GUI session's startup applications, to add a launcher for `notify-listener.py`. That way it starts up any time you login.

> | Firewalls or other special routing, other than being on the same local network, may impede notifications. In the future the plugin may be enhanced to use remote SSH port forwarding to solve this problem. |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

The plugin is simple to use; copy it to `~/.irssi/scripts` and then run irssi.  Then in irssi, run

```
/LOAD perl
/SCRIPT LOAD notify.pl
```

If you want this to load automatically, an easy way to do that is:

```
mkdir ~/.irssi/scripts/autorun
cd ~/.irssi/scripts/autorun
ln -s ../notify.pl
```

If you are running remotely, you should set the `notify_remote` irssi variable to the host name or IP address of your **local** system, as the remote machine would identify it:

```
/SET notify_remote my_laptop
```

To test, have someone shout at you (using your name in a channel), or send a private message to your nick with `/MSG`.

## Known Bugs/Problems ##

Seems to work fine with SSH + screen, as most people prefer to use irssi from what I gather.  ~~You need to have X forwarded on the SSH session, of course!  (Use `ssh -X` to forward X traffic over the session.)~~ The newer D-Bus code should make it unnecessary to forward X traffic, as now the communication happens as D-Bus messages.

# To Do #

  * Add a reload option
  * Use SSH remote forwarding to carry message data to a local notifier when using SSH+screen
  * Add a function for sending SMS email notifications
  * Have a way of sending back a one-liner from the notification