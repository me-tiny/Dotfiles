import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import qs.config

RowLayout {
    id: root
    required property var panel

    FontMetrics {
        id: fm
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
    }

    readonly property int em: Math.max(1, Math.round(fm.averageCharacterWidth))
    spacing: Math.round(em * 0.15)

    Repeater {
        model: Hyprland.workspaces.values
            .filter(ws => ws.id > 0)
            .filter(ws => ws.monitor && ws.monitor.name === root.panel.screen.name)

        Rectangle {
            id: cell
            required property var modelData

            Layout.fillHeight: true
            color: "transparent"

            readonly property int padX: Math.round(root.em * 0.25)
            readonly property bool isFocused: Hyprland.focusedWorkspace === modelData

            readonly property int minCell: Math.round(root.em * 1.2)
            Layout.preferredWidth: Math.max(minCell, Math.ceil(label.contentWidth) + padX * 2)

            Text {
                id: label
                text: cell.modelData.id
                color: cell.isFocused ? Theme.teal : Theme.overlay
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize
                font.bold: true
                anchors.centerIn: parent
            }

            Rectangle {
                height: Math.max(2, Math.round(root.em * 0.18))
                width: Math.ceil(label.contentWidth)
                color: Theme.mauve
                anchors.horizontalCenter: label.horizontalCenter
                anchors.bottom: parent.bottom
                opacity: cell.isFocused ? 1 : 0
            }

            MouseArea {
                anchors.fill: parent
                onClicked: cell.modelData.activate()
            }
        }
    }
}
