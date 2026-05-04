import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import qs.config

PopupWindow {
    id: drawerWin
    required property var tray

    visible: tray.mode === "drawer"
    color: "transparent"
    surfaceFormat.opaque: false

    anchor.window: tray.panel
    anchor.rect.width: 1
    anchor.rect.height: 1
    anchor.adjustment: PopupAdjustment.FlipY | PopupAdjustment.ResizeY
    anchor.onAnchoring: tray.applyAnchor(drawerWin)

    readonly property int boxWidth:
        Math.max(1, Math.min(340, row.implicitWidth + 16))
    readonly property int boxHeight: Math.max(1, col.implicitHeight)

    implicitWidth: tray.popupWidth
    implicitHeight: boxHeight

    onImplicitHeightChanged: if (visible) anchor.updateAnchor()
    onVisibleChanged: if (visible) {
        anchor.updateAnchor()
        keys.forceActiveFocus()
    }

    HoverHandler {
        onHoveredChanged: drawerWin.tray.drawerHovered = hovered
    }

    FocusScope {
        id: keys
        focus: drawerWin.visible
        Keys.onEscapePressed: (e) => { drawerWin.tray.closeAll(); e.accepted = true }
    }

    ClippingRectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        width: drawerWin.boxWidth
        height: drawerWin.boxHeight

        radius: 10
        topLeftRadius: 0
        topRightRadius: 0
        bottomRightRadius: 0
        color: Theme.base

        opacity: drawerWin.visible ? 1 : 0
        scale: drawerWin.visible ? 1 : 0.98
        Behavior on opacity { NumberAnimation { duration: 140; easing.type: Easing.OutQuad } }
        Behavior on scale   { NumberAnimation { duration: Theme.popupAnimMs; easing.type: Easing.OutQuad } }

        Column {
            id: col
            anchors.fill: parent
            padding: 8
            spacing: 6

            RowLayout {
                id: row
                spacing: 4

                Repeater {
                    model: SystemTray.items
                    delegate: Rectangle {
                        id: iconCell
                        required property var modelData

                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        radius: 6
                        color: iconHover.containsMouse ? Qt.rgba(1, 1, 1, 0.06) : "transparent"

                        IconImage {
                            anchors.centerIn: parent
                            width: 16
                            height: 16
                            source: iconCell.modelData.icon
                        }

                        MouseArea {
                            id: iconHover
                            anchors.fill: parent
                            hoverEnabled: true
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked: (mouse) => {
                                if (mouse.button === Qt.LeftButton) {
                                    iconCell.modelData.activate()
                                    drawerWin.tray.closeAll()
                                } else if (mouse.button === Qt.RightButton) {
                                    drawerWin.tray.showMenuFor(iconCell.modelData)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
