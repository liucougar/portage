#!/sbin/runscript
#
# agnclientd:	Starts the AGNS NetClient Daemon
#
# $Header: $

depend() {
	need net localmount
	after bootmisc
}

start() {
    ebegin "Starting AGNS NetClient Daemon"
    start-stop-daemon --start --exec /opt/agns/bin/agnclientd \
        --pidfile /var/run/agnclientd.pid
    eend $?
}

stop() {
    ebegin "Stopping AGNS NetClient Daemon"
    start-stop-daemon --stop --exec /opt/agns/bin/agnclientd \
         --pidfile /var/run/agnclientd.pid
    eend $?
}
