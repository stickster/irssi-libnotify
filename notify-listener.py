#!/usr/bin/python

import os, sys
try:
    from gi.repository import Notify, GObject
except:
    print >> sys.stderr, 'Could not locate pygobject'
    sys.exit(-1)
import dbus
import dbus.mainloop.glib

player = None
for path in os.environ['PATH'].split(os.pathsep):
    if os.path.isfile(os.path.join(path, 'canberra-gtk-play')):
        player = os.path.join(path, 'canberra-gtk-play')
        break

class IrssiListener:
    def __init__(self):
        dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
        self.bus = dbus.SessionBus()
        self.bus.add_signal_receiver(self.notify,
                                     signal_name='IrssiNotify',
                                     dbus_interface='org.irssi.Irssi',
                                     path='/org/irssi/Irssi')
        Notify.init('irssi')

    def notify(self, subject, message):
        print subject, message
        n = Notify.Notification.new(subject.encode('utf-8'),
                                    message.encode('utf-8'),
                                    'dialog-information')
        n.show()

        # It would be more kosher to do this with GStreamer, but in
        # the interest of time:
        if player is not None:
            os.spawnlp(os.P_NOWAIT, 'canberra-gtk-play',
                       player, '-i', 'message-new-instant')

    def __del__(self):
        Notify.uninit()

if __name__ == '__main__':
    l = IrssiListener()
    loop = GObject.MainLoop()
    loop.run()
