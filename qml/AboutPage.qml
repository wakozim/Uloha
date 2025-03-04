import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


MyPage {
    id: pageAbout

    title: qsTr("About")
    
    property real margin: 35
    
    ColumnLayout {
        width: parent.width 
        anchors.centerIn: parent

        Text {
            Layout.alignment: Qt.AlignHCenter

            textFormat: Text.RichText
            wrapMode: Text.WordWrap

            text: "<b>Uloha<b>"
        }

        Text {
            Layout.fillWidth: true
            Layout.leftMargin: margin
            Layout.rightMargin: margin
            horizontalAlignment: Text.AlignHCenter

            textFormat: Text.RichText
            wrapMode: Text.WordWrap

            text: "<p>A simple and lightweight task manager application. It helps users create, organize, and track their daily tasks in a clean and intuitive interface.</p>"
        }
    }
}
