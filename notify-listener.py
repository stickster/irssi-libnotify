#!/usr/bin/python

import os, sys
try:
    from gi.repository import Notify, GObject
except:
    print >> sys.stderr, 'Could not locate pygobject'
    sys.exit(-1)
import dbus
import dbus.mainloop.glib

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
        os.spawnlp(os.P_NOWAIT, 'ogg123', 'ogg123', '-q',
                   '/usr/share/sounds/freedesktop/stereo/message-new-instant.oga')

    def __del__(self):
        Notify.uninit()

if __name__ == '__main__':
    l = IrssiListener()
    loop = GObject.MainLoop()
    loop.run()
