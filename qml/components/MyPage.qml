import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import Uloha


Rectangle {
    id: page

    clip: true
    property string title: "Title"

    color: Palette.background

    Rectangle {
        id: curtain
        color: "#FFFFFF"
        opacity: app._progressOpening*0.5
        anchors.fill: parent
        z: 100
    }
}
