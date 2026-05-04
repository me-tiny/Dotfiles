import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components
import qs.bar.widgets as W

Item {
    id: root
    required property var panel

    anchors.left: parent.left
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.leftMargin: Theme.padding

    implicitWidth: row.implicitWidth

    RowLayout {
        id: row
        anchors.fill: parent
        spacing: Theme.spacing

        W.Workspaces { panel: root.panel }
        Separator { }
        W.ActiveWindow { }
    }
}
