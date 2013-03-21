You can find this project online at:
  http://code.google.com/p/irssi-libnotify/source/browse/trunk

For information on how to retrieve the latest copy, refer to:
  http://code.google.com/p/irssi-libnotify/source/checkout 

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
notify-listener.py.

3. Copy notify.pl to $HOME/.irssi/scripts/.

4. To load it at irssi launch, make sure you have a
$HOME/.irssi/scripts/autorun/ folder.  Then do this:
   $ ln -s ../notify.pl $HOME/.irssi/scripts/autorun/

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

In the future I'm going to add a feature to provide messages raw over
a remotely forwarded port, so you won't need any special key handling
or have to worry about firewalls and other such stuff.  Thanks for
trying this out.


-- PWF 2013-03-21
