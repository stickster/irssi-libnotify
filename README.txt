You can find this project online at:
  https://github.com/stickster/irssi-libnotify

This is a slightly nicer D-Bus approach that plays nicely with the
GNOME Shell's notification area.  If you are looking for the older,
simpler version using libnotify, simply check out the old-libnotify
branch instead.

To make this script work better for people who use irssi remotely via
SSH (often with screen), I've separated out the actual notifier into a
small listener program.  That piece is written in Python so it should
be easy to read and understand.


REQUIREMENTS
============

 * irssi
 * libnotify >= 0.7  (but slightly older libnotify may work)
 * pygobject >= 3.0
 * perl-HTML-Parser


INSTRUCTIONS
============

1. Copy notify-listener.py and irssi-notifier.sh to your $HOME/bin/
directory.

2. Run gnome-session-properties and add an automatic launcher for
notify-listener.py.  In very new versions of GNOME, you may need
to construct a .desktop file and add it to ~/.config/autostart/ .

3. Copy notify.pl to the $HOME/.irssi/scripts/ directory.

4. To load it at irssi launch, make sure you have a
$HOME/.irssi/scripts/autorun/ folder.  Then set up a symbolic link
to the script:
   $ ln -s ../notify.pl $HOME/.irssi/scripts/autorun/

5. Start the listener int he background:
   $ notify-listener &

6. Start or restart irssi, or else load the notify script in irssi:
   /SCRIPT LOAD notify.pl

If you are running irssi remotely, currently your remote machine
account would need to be able to SSH back to your local box without a
passphrase.  You'll need to set that up yourself, using 'ssh-copy-id'
or another method.

Then in irssi, use /SET notify_remote <HOST> to activate the remote
notification bit.  Replace <HOST> with the name or IP address of the
local machine you're on, *as it would be known to the remote
machine*.  This is most useful if you're on the same local network
with the other box; firewalls or other non-local routing will probably
make it difficult to use this feature.

If your local machine is a Mac, add the "M" character to the end of
the IP address.  Obviously on Macs you can skip steps 1, 2, and 5.
The script will use the built-in osascript binary to trigger
notifications.  You still need to make sure your SSH key works from
the system on which irssi is running to the Mac you're using locally.

In the future I'm going to add a feature to provide messages raw over
a remotely forwarded port, so you won't need any special key handling
or have to worry about firewalls and other such stuff.  Thanks for
trying this out.


-- PWF 2015-03-18
