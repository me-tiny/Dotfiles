pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property int usage: _usage
    property int _usage: 0
    property double _lastIdle: 0
    property double _lastTotal: 0

    function _update(text) {
        const line = (text || "").split("\n")[0]
        if (!line) return

        const p = line.trim().split(/\s+/)
        const user = parseInt(p[1]) || 0
        const nice = parseInt(p[2]) || 0
        const system = parseInt(p[3]) || 0
        const idle = parseInt(p[4]) || 0
        const iowait = parseInt(p[5]) || 0
        const irq = parseInt(p[6]) || 0
        const softirq = parseInt(p[7]) || 0

        const total = user + nice + system + idle + iowait + irq + softirq
        const idleTime = idle + iowait

        if (root._lastTotal > 0) {
            const dt = total - root._lastTotal
            const di = idleTime - root._lastIdle
            if (dt > 0) root._usage = Math.round(100 * (dt - di) / dt)
        }

        root._lastTotal = total
        root._lastIdle = idleTime
    }

    readonly property var _stat: FileView {
        path: "/proc/stat"
        onLoaded: root._update(text())
        onLoadFailed: (e) => console.warn("cpu: failed to read /proc/stat: ", e)
    }

    readonly property var _timer: Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: root._stat.reload()
    }

    Component.onCompleted: _stat.reload()
}
