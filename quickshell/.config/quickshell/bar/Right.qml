import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components
import qs.bar.widgets as W

Item {
    id: root
    required property var panel

    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.rightMargin: Theme.padding

    implicitWidth: row.implicitWidth

    RowLayout {
        id: row
        anchors.fill: parent
        spacing: Theme.spacing

        W.CpuUsage { }
        Separator { }
        W.Clock { }
        Separator { }
        W.Tray { panel: root.panel }
    }
}
