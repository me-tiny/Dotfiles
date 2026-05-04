pragma Singleton

import Quickshell
import Quickshell.Services.Mpris
import QtQuick

Singleton {
    id: root
    property var player: Mpris.players.values.find(p => p.identity === "Spotify")

    readonly property bool isPlaying:
        !!player && player.playbackState === MprisPlaybackState.Playing

    readonly property string text: {
        if (!player) return ""
        const title = player.trackTitle || "No Title"
        const artist = player.trackArtist || ""
        return artist ? `${title} - ${artist}` : title
    }
}
