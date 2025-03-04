import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs


Rectangle {
    id: page

    clip: true
    property string title: "Title"

    Rectangle {
        id: curtain
        color: "black"
        opacity: app._progressOpening*0.5
        anchors.fill: parent
        z: 100
    }
}
