import QtQuick
import QtQuick.Controls


MyPage {
    id: pageAbout

    title: qsTr("About")


    Label {
        anchors.centerIn: parent
        text: qsTr("About")
    }
}
