import QtQuick

import qs.config
import qs.components
import qs.services as Services

BarText {
    id: root
    property int maxWidth: 500

    text: Services.Spotify.text
    color: Theme.green
    elide: Text.ElideRight
    width: Math.min(implicitWidth, maxWidth)

    visible: opacity > 0
    opacity: Services.Spotify.isPlaying ? 1 : 0
    Behavior on opacity {
        NumberAnimation { duration: 300; easing.type: Easing.OutQuad }
    }
}
