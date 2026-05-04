pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property color base:    "#1e1e2e"
    readonly property color text:    "#cdd6f4"
    readonly property color overlay: "#6c7086"
    readonly property color teal:    "#94e2d5"
    readonly property color mauve:   "#cba6f7"
    readonly property color red:     "#f38ba8"
    readonly property color yellow:  "#f9e2af"
    readonly property color blue:    "#89b4fa"
    readonly property color green:   "#a6e3a1"

    readonly property string fontFamily: "MonoLisa"
    readonly property int fontSize: 18

    readonly property int barHeight: 32
    readonly property int padding: 8
    readonly property int spacing: 8

    readonly property int popupAnimMs: 180
}
