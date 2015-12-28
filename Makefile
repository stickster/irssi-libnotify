TARGETS = install|uninstall

help:
	echo "Usage: make <$(TARGETS)>"

install:
	install -m755 irssi-notifier.sh $$HOME/.local/bin/irssi-notifier.sh
	install -m755 notify-listener.py $$HOME/.local/bin/notify-listener.py
	install -m644 notify.pl  $$HOME/.irssi/scripts/notify.pl
	ln -s $$HOME/.irssi/scripts/notify.pl $$HOME/.irssi/scripts/autorun/notify.pl

uninstall:
	rm $$HOME/.local/bin/irssi-notifier.sh
	rm $$HOME/.local/bin/notify-listener.py
	rm $$HOME/.irssi/scripts/autorun/notify.pl
	rm $$HOME/.irssi/scripts/notify.pl

.PHONY: install uninstall
.SILENT: help
