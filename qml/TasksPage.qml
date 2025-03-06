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
            width: grid.cellWidth - spacing
            height: grid.cellHeight - spacing
            color: completed ? "#B1B1B1" : "#FF0000"
            clip: true
            Column {
                anchors.fill: parent
                Text { text: title; anchors.horizontalCenter: parent.horizontalCenter }
                Text { text: description; anchors.horizontalCenter: parent.horizontalCenter; color: grid.isCurrentItem ? "red" : "black" }
                CheckBox {
                    checked: completed
                    onClicked: taskVM.toggleCompleted(id)
                }
            }
        }
    }

    Component {
        id: activeTask 
        SwipeDelegate {
            text: title 
            id: test
            width: grid.cellWidth - spacing
            height: grid.cellHeight - spacing
            clip: true

            GridView.onRemove: removeAnimation.start()

            SequentialAnimation {
                id: removeAnimation

                PropertyAction {
                    target: activeTask
                    property: "GridView.delayRemove"
                    value: true
                }
                NumberAnimation {
                    target: test 
                    property: "width"
                    to: 0
                    easing.type: Easing.InOutQuad
                }
                ScriptAction {
                    script: {
                        taskVM.toggleCompleted(id);
                    }
                }
                PropertyAction {
                    target: activeTask
                    property: "GridView.delayRemove"
                    value: false
                }
            }

       swipe.right: Button {
            text: "Delete"
            width: height 
            height: parent.height
        }

        swipe.onCompleted: {
            if (swipe.position < 0) {
                removeAnimation.start();
            }
        }

        }
    }

    ColumnLayout {
        anchors.fill: parent

        Button {
            id: newTaskButton
            text: qsTr("New Task")

            padding: 10
            Layout.margins: 20
            Layout.fillWidth: true
            font.pixelSize: 15

            HoverHandler {
                cursorShape: Qt.PointingHandCursor
            }

            contentItem: Text {
                text: newTaskButton.text
                font: newTaskButton.font
                opacity: enabled ? 1.0 : 0.3
                color: newTaskButton.down ? "#BBBBBB" : "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                color: newTaskButton.hovered ? "#2C3E50" : "#2C3E50";
                radius: 10;
            }

            onClicked: {
                loader.source = "NewTaskPage.qml"
            }
        }

        Label {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter

            font.bold: true
            font.pixelSize: 20

            text: qsTr("Active tasks")
        }

        GridView {
            id: grid

            property real _minCellWidth: 100
            property real _cellWidth: (parent.width - 20*2) / columns
            property real _cellWidth2: (parent.width - 20*2) / 2
            cellWidth: _cellWidth > _minCellWidth ? _cellWidth : _cellWidth2

            model: taskVM ? taskVM.activeTasksModel : null
            delegate: activeTask

            clip: true
            boundsBehavior: Flickable.StopAtBounds

            Layout.margins: 20
            Layout.fillWidth: true
            Layout.fillHeight: true
        }


        Label {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter

            font.bold: true

            text: qsTr("Done")
        }


        GridView {
            id: doneGrid

            property real _minCellWidth: 100
            property real _cellWidth: (parent.width - 20*2) / columns
            cellWidth: _cellWidth > _minCellWidth ? _cellWidth : _minCellWidth

            model: taskVM ? taskVM.completedTasksModel : null
            delegate: completedTask

            clip: true
            boundsBehavior: Flickable.StopAtBounds

            Layout.margins: 20
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
