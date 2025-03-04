import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


MyPage {
    id: pageTasks

    title: qsTr("Tasks")

    property int columns: 3
    property int spacing: 10
    
    // TODO: Make one component for this and activeTask 
    Component {
        id: completedTask 
        Rectangle {
            z: 10
            width: grid.cellWidth - spacing
            height: grid.cellHeight - spacing
            color: completed ? "#B1B1B1" : "#FF0000" 
            Column {
                anchors.fill: parent
                Text { text: title; anchors.horizontalCenter: parent.horizontalCenter }
                Text { text: description; anchors.horizontalCenter: parent.horizontalCenter; color: grid.isCurrentItem ? "red" : "black"}
                CheckBox {
                    checked: completed
                    onClicked: taskVM.toggleCompleted(id)
                }
            }
        }
    }

    Component {
        id: activeTask 
        Rectangle {
            z: 10
            width: grid.cellWidth - spacing
            height: grid.cellHeight - spacing
            color: completed ? "#B1B1B1" : "#FF0000" 
            Column {
                anchors.fill: parent
                Text { text: title; anchors.horizontalCenter: parent.horizontalCenter }
                Text { text: description; anchors.horizontalCenter: parent.horizontalCenter; color: grid.isCurrentItem ? "red" : "black"}
                CheckBox {
                    checked: completed
                    onClicked: taskVM.toggleCompleted(id)
                }
            }
        }
    }

    ColumnLayout {
        z: 100
        anchors.fill: parent

        Button {
            id: newTaskButton
            text: qsTr("New Task")

            Layout.margins: 20
            Layout.fillWidth: true
            
            contentItem: Text {
                text: newTaskButton.text
                font: newTaskButton.font
                opacity: enabled ? 1.0 : 0.3
                color: newTaskButton.down ? "#17a81a" : "#21be2b"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: "#202020"
            }

            onClicked: {
                loader.source = "qml/NewTaskPage.qml" 
            }
        }

        Label {
            text: qsTr("Active tasks")
        }

        GridView {
            id: grid

            model: taskVM ? taskVM.activeTasksModel : null
            delegate: activeTask 
            
            clip: true
            
            Layout.margins: 20
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Label {
            text: qsTr("Done")
        }

        
        GridView {
            id: doneGrid

            model: taskVM ? taskVM.completedTasksModel : null
            delegate: completedTask 

            clip: true
            
            Layout.margins: 20
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
