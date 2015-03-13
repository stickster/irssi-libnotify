# Introduction #

The plugin is simple to use; copy it to ~/.irssi/scripts and then run irssi.  Then in irssi, run

> /LOAD perl
> /SCRIPT LOAD notify.pl

If you want this to load automatically, an easy way to do that is:

> mkdir ~/.irssi/scripts/autorun
> cd $_&& ln -s ../notify.pl_

# Details #

Seems to work fine with SSH + screen, as most people prefer to use irssi from what I gather.

# ToDo #

**Add notify support for {X,}DCC** Find a nice systematic function for making messages entity-safe
