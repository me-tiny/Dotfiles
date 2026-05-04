import QtQuick

import qs.config
import qs.components
import qs.services as Services

BarText {
    text: "CPU: " + Services.Cpu.usage + "%"
    color: Theme.yellow
}
