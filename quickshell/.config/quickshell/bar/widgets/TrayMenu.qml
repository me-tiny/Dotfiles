import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

import qs.config

PopupWindow {
    id: menuWin
    required property var tray

    visible: tray.mode === "menu"
    color: "transparent"
    surfaceFormat.opaque: false

    anchor.window: tray.panel
    anchor.rect.width: 1
    anchor.rect.height: 1
    anchor.adjustment: PopupAdjustment.FlipY | PopupAdjustment.ResizeY
    anchor.onAnchoring: tray.applyAnchor(menuWin)

    readonly property int boxWidth: Math.max(260, col.implicitWidth)
    readonly property int boxHeight: Math.max(1, col.implicitHeight + 32)

    implicitWidth: tray.popupWidth
    implicitHeight: boxHeight

    onImplicitHeightChanged: if (visible) anchor.updateAnchor()
    onVisibleChanged: if (visible) {
        anchor.updateAnchor()
        keys.forceActiveFocus()
    }

    readonly property var stack: tray.menuStack

    HoverHandler {
        onHoveredChanged: menuWin.tray.menuHovered = hovered
    }

    FocusScope {
        id: keys
        focus: menuWin.visible
        Keys.onEscapePressed: (e) => { menuWin.tray.closeAll(); e.accepted = true }
    }

    QsMenuOpener {
        id: opener
        menu: menuWin.stack.length > 0
              ? menuWin.stack[menuWin.stack.length - 1]
              : menuWin.tray.menuRoot
    }

    ClippingRectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        width: menuWin.boxWidth
        height: menuWin.boxHeight

        radius: 10
        topLeftRadius: 0
        topRightRadius: 0
        bottomRightRadius: 0
        color: Theme.base

        opacity: menuWin.visible ? 1 : 0
        scale: menuWin.visible ? 1 : 0.98
        Behavior on opacity { NumberAnimation { duration: 140; easing.type: Easing.OutQuad } }
        Behavior on scale   { NumberAnimation { duration: Theme.popupAnimMs; easing.type: Easing.OutQuad } }

        ColumnLayout {
            id: col
            anchors.fill: parent
            anchors.margins: 8
            spacing: 2

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 28
                radius: 6
                color: "transparent"

                readonly property bool nested: menuWin.stack.length > 0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: parent.nested ? "󰌑 Back" : "󰌑 Tray"
                    color: Theme.text
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize - 2
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: parent.nested ? menuWin.tray.popMenu()
                                             : menuWin.tray.backToDrawer()
                }
            }

            Repeater {
                model: opener.children
                delegate: Rectangle {
                    id: entry
                    required property var modelData

                    Layout.fillWidth: true
                    implicitHeight: modelData.isSeparator ? 10 : 28
                    radius: 6
                    color: "transparent"
                    opacity: modelData.enabled ? 1 : 0.45

                    Rectangle {
                        visible: entry.modelData.isSeparator
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        height: 1
                        color: Theme.overlay
                        opacity: 0.6
                    }

                    Rectangle {
                        visible: !entry.modelData.isSeparator
                        anchors.fill: parent
                        radius: 6
                        color: hover.containsMouse ? Qt.rgba(1, 1, 1, 0.06) : "transparent"

                        Row {
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            anchors.rightMargin: 8
                            spacing: 8

                            IconImage {
                                visible: entry.modelData.icon !== ""
                                width: 16
                                height: 16
                                anchors.verticalCenter: parent.verticalCenter
                                source: entry.modelData.icon
                            }

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: entry.modelData.text
                                color: Theme.text
                                font.family: Theme.fontFamily
                                font.pixelSize: Theme.fontSize - 2
                                elide: Text.ElideRight
                                width: parent.width - 40
                            }

                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: entry.modelData.hasChildren ? "›" : ""
                                color: Theme.overlay
                                font.family: Theme.fontFamily
                                font.pixelSize: Theme.fontSize - 2
                            }
                        }

                        MouseArea {
                            id: hover
                            anchors.fill: parent
                            hoverEnabled: true
                            enabled: entry.modelData.enabled && !entry.modelData.isSeparator
                            onClicked: {
                                if (entry.modelData.hasChildren) {
                                    menuWin.tray.pushMenu(entry.modelData)
                                } else {
                                    entry.modelData.triggered()
                                    menuWin.tray.closeAll()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
