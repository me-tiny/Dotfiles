import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

import qs.config
import qs.components

BarText {
    readonly property var focused: Hyprland.activeToplevel

    text: focused ? focused.title: ""
    color: Theme.mauve
    elide: Text.ElideRight
    Layout.maximumWidth: 500
}
