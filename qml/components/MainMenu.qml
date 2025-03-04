import QtQuick
import QtQuick.Controls
import Uloha


// TODO: It’s wrong to keep pages in the MainMenu itself.

Item {
    id: menu

    signal menuItemClicked( string item, string page )
    property alias currentItem: listViewMenu.currentIndex

    ListModel {
        id: modelMenu
        ListElement {
            item: "page_tasks"
            title: "Tasks"
            icon: "qrc:/images/icon_game.png"
            page: "TasksPage.qml"
        }
        ListElement {
            item: "settings"
            title: "Settings"
            icon: "qrc:/images/icon_settings.png"
            page: "SettingsPage.qml"
        }
        ListElement {
            item: "about"
            title: "About"
            icon: "qrc:/images/icon_info.png"
            page: "AboutPage.qml"
        }
    }

    Rectangle {
        id: logoWtapper
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        width: parent.width
        height: width*0.5
        color: Palette.primary //"#3078fe" //this color is equal to the background of imgLogo
        clip: true
        Image {
            id: imgLogo
            source: "qrc:/images/background.jpg"
            height: parent.height
            width: parent.width
            antialiasing: true
            smooth: true
            anchors.top: parent.top
            anchors.left: parent.left
            opacity: 0.5
        }
    }
    Image {
        id: imgShadow
        anchors.top: logoWtapper.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 10*app.dp
        z: 4
        source: "qrc:/images/shadow_title.png"
    }
    ListView {
        id: listViewMenu
        anchors.top: logoWtapper.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        clip: true
        model: modelMenu
        delegate: componentDelegate
    }

    Component {
        id: componentDelegate

        Rectangle {
            id: wrapperItem
            height: 60*app.dp
            width: parent.width
            color: wrapperItem.ListView.isCurrentItem || ma.pressed ? Palette.currentHighlightItem : "transparent"
            Image {
                id: imgItem
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 0.5*imgItem.width
                height: parent.height*0.5
                width: height
                source: icon
                visible: icon != ""
                smooth: true
                antialiasing: true
            }

            Label {
                id: textItem
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: imgItem.right
                anchors.leftMargin: 0.7*imgItem.width
                text: title
                font.pixelSize: parent.height*0.3
                color: wrapperItem.ListView.isCurrentItem ? Palette.darkPrimary : Palette.primaryText
            }


            MouseArea {
                id: ma
                anchors.fill: parent
                enabled: app.menuIsShown
                onClicked: {
                    menu.menuItemClicked(item, page)
                    listViewMenu.currentIndex = index
                }
            }
        }

    }
}
