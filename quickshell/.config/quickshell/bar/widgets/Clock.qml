import Quickshell
import QtQuick

import qs.config
import qs.components

BarText {
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    text: Qt.formatDateTime(clock.date, "ddd, MMM, dd - hh:mm AP")
    color: Theme.mauve
}
