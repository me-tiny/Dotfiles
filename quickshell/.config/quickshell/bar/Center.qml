import QtQuick

import qs.bar.widgets as W

Item {
    anchors.centerIn: parent
    implicitWidth: now.width
    implicitHeight: now.implicitHeight

    W.NowPlaying {
        id: now
        anchors.centerIn: parent
        maxWidth: 500
    }
}
