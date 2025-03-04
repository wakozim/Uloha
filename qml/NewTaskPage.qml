import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


MyPage {
    id: pageAbout

    title: qsTr("New Task")

    ColumnLayout {
        //width: parent.width
        //height: parent.height
        anchors.centerIn: parent
        spacing: 10

        TextArea {
            id: titleInput
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            placeholderText: qsTr("Titile")
        }
        TextArea {
            id: descriptionInput
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            placeholderText: qsTr("Description")
        }
        Button {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            id: addButton
            text: qsTr("Add")
            onClicked: {
                let title = titleInput.text
                if (!title) return;
                let description1 = descriptionInput.text
                taskVM.addTask(title, description1)
                loader.source = "TasksPage.qml" 
            }
        }
    }
}
