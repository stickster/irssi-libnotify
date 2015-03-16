You can find this project online at:

  https://github.com/stickster/irssi-libnotify

For information on how to retrieve the latest copy, refer to:

  https://github.com/stickster/irssi-libnotify/blob/master/README.txt

This is a slightly nicer D-Bus approach that plays nicely with the
GNOME Shell's notification area.  If you are looking for the older,
simpler version using libnotify, simply check out the old-libnotify
branch instead.

To make this script work better for people who use `irssi` remotely via
SSH (often with screen), I've separated out the actual notifier into a
small listener program. That piece is written in Python so it should be
easy to read and understand.


REQUIREMENTS
============

 * irssi
 * libnotify >= 0.7  (but slightly older libnotify may work)
 * pygobject >= 3.0
 * perl-HTML-Parser


INSTRUCTIONS
============

1. Clone the repo:

      $ git clone https://github.com/stickster/irssi-libnotify

2. Copy the 'notify-listener' and 'irssi-notifier' to your $HOME/bin
   directory.

3. Copy notify.pl to $HOME/.irssi/scripts/ directory.

4. To load it at `irssi` launch, make sure you have the below directory:

      $HOME/.irssi/scripts/autorun/

    Then, setup a symbolic link to the 'notify' script:

      $ ln -s ../notify.pl $HOME/.irssi/scripts/autorun/

5. Invoke the notification 'notify-listener' script in the background:

        $ ~/bin/notify-listener.py &

6. Load the 'notify' script from `irssi`:

        [(status)] /SCRIPT LOAD notify.pl

7. Test it by sending a private message to yourself, and you should see
   GNOME notifcations.

If you are running `irssi` remotely, currently your remote machine
account would need to be able to SSH back to your local box without a
passphrase. You'll need to set that up yourself, using 'ssh-copy-id'
or another method.

Then in `irssi`, use /SET notify_remote <HOST> to activate the remote
notification bit.  Replace <HOST> with the name or IP address of the
local machine you're on, *as it would be known to the remote machine*.
This is most useful if you're on the same local network with the other
box; firewalls or other non-local routing will probably make it
difficult to use this feature.

In the future I'm going to add a feature to provide messages raw over a
remotely forwarded port, so you won't need any special key handling or
have to worry about firewalls and other such stuff. Thanks for trying
this out.
