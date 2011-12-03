#!/sbin/runscript
#
# agnLogd:	Starts the AGNS Log Daemon
#
# $Header: $

depend() {
    need net localmount
    after bootmisc
}


start() {
    ebegin "Starting AGNS Log Daemon"
    start-stop-daemon --start --exec /opt/agns/bin/agnLogd \
        --pidfile /var/run/agnLogd.pid
    eend $?
}

stop() {
    ebegin "Stopping AGNS Log Daemon"
    start-stop-daemon --stop --exec /opt/agns/bin/agnLogd \
         --pidfile /var/run/agnLogd.pid
    eend $?
}
