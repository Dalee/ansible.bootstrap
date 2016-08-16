#!/bin/sh
### BEGIN INIT INFO
# Provides:          avahi-alias
# Required-Start:    $remote_fs dbus
# Required-Stop:     $remote_fs dbus
# Should-Start:	     $syslog
# Should-Stop:       $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Avahi subdomain announcer
# Description:       Announce multiple avahi cname aliases across your local network
### END INIT INFO

DESC="Announce multiple avahi cname aliases across your local network"
NAME="avahi-alias"
DAEMON="/usr/local/bin/avahi-alias"
PIDFILE="/var/run/avahi-aliases.pid"
SCRIPTNAME=/etc/init.d/$NAME

test -x $DAEMON || exit 0

. /lib/lsb/init-functions

d_start() {
    test -f $PIDFILE || $DAEMON start
}

d_stop() {
    test -f $PIDFILE && $DAEMON stop
}

d_status() {
    test -f $PIDFILE
}

case "$1" in
    start)
        log_daemon_msg "Starting $DESC" "$NAME"
        d_start
        log_end_msg $?
        ;;
    stop)
        log_daemon_msg "Stopping $DESC" "$NAME"
        d_stop
        log_end_msg $?
        ;;
    restart)
        log_daemon_msg "Restarting $DESC" "$NAME"
        d_stop
        if [ "$?" -eq 0 ]; then
                d_start
                log_end_msg $?
        else
                log_end_msg 1
        fi
        ;;
    status)
        d_status
        ;;
    *)
        echo "Usage: $SCRIPTNAME {start|stop|restart|status}" >&2
        exit 3
        ;;
esac

exit 0
