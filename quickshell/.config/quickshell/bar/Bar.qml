import Quickshell
import QtQuick

import qs.config

PanelWindow {
    id: panel
    required property var modelData
    screen: modelData

    anchors { top: true; left: true; right: true }
    implicitHeight: Theme.barHeight
    color: Theme.base

    Left { panel: panel }
    Center { }
    Right { panel: panel }
}
