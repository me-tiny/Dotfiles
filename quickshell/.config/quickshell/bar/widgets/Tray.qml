import QtQuick
import Quickshell.Hyprland

import qs.config

Item {
    id: root
    required property var panel
    property string mode: "closed"
    property var menuRoot: null
    property var menuStack: []
    readonly property bool overlayOpen: mode !== "closed"
    property bool drawerHovered: false
    property bool menuHovered: false
    readonly property bool pointerInside:
        buttonHover.containsMouse || drawerHovered || menuHovered

    function showDrawer() {
        _beginOverlay()
        Qt.callLater(() => mode = "drawer")
    }

    function showMenuFor(item) {
        if (!item || !item.hasMenu) return
        menuRoot = item.menu
        menuStack = []
        _beginOverlay()
        Qt.callLater(() => mode = "menu")
    }

    function backToDrawer() {
        menuStack = []
        menuRoot = null
        showDrawer()
    }

    function pushMenu(entry) { menuStack = menuStack.concat([entry]) }
    function popMenu()        { menuStack = menuStack.slice(0, -1) }

    function closeAll() {
        mode = "closed"
        menuStack = []
        menuRoot = null
        _endOverlay()
    }

    function _beginOverlay() {
        panel.focusable = true
        focusGrab.active = true
    }

    function _endOverlay() {
        panel.focusable = false
        focusGrab.active = false
    }

    onPointerInsideChanged: {
        if (!overlayOpen) return
        if (pointerInside) hoverDismiss.stop()
        else hoverDismiss.restart()
    }

    Timer {
        id: hoverDismiss
        interval: 150
        repeat: false
        onTriggered: { if (overlayOpen && !pointerInside) closeAll() }
    }

    HyprlandFocusGrab {
        id: focusGrab
        active: false
        windows: [ panel, drawer, menu ]
        onCleared: closeAll()
    }

    FocusScope {
        id: panelKeys
        focus: root.overlayOpen
        Keys.onEscapePressed: (e) => { if (root.overlayOpen) { closeAll(); e.accepted = true } }
    }

    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    Rectangle {
        id: button
        implicitWidth: 24
        implicitHeight: 24
        radius: 6
        color: buttonHover.containsMouse ? Qt.rgba(1, 1, 1, 0.06) : "transparent"

        Text {
            anchors.centerIn: parent
            text: "𑁔"
            color: Theme.text
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize + 6
        }

        MouseArea {
            id: buttonHover
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton
            onClicked: root.mode === "drawer" ? root.closeAll() : root.showDrawer()
        }
    }

    readonly property int popupWidth: Math.max(drawer.boxWidth, menu.boxWidth)

    function applyAnchor(win) {
        const p = panel.contentItem.mapFromItem(button, 0, button.height)
        win.anchor.rect.y = p.y + 4
        win.anchor.rect.x = Math.max(0, panel.width - popupWidth)
    }

    TrayDrawer {
        id: drawer
        tray: root
    }

    TrayMenu {
        id: menu
        tray: root
    }
}
