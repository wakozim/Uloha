import QtQuick
import QtCore
import QtQuick.Window
import QtQuick.Controls
import Uloha


ApplicationWindow {
    id: app

    property string appTitle: "Uloha"

    width: 360
    height: 640

    visible: true

    property int dp: 1

    Settings {
        id: settings
    }

    property alias currentPage: loader.source

    property int durationOfMenuAnimation: 500
    property int menuWidth: 200
    property int widthOfSeizure: 100
    property bool menuIsShown: Math.abs(menuView.x) < (menuWidth*0.5) ? true : false
    property real menuProgressOpening


    Rectangle {
        id: normalView
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        color: "black"

        //*************************************************//
        Rectangle {
            id: menuBar
            z: 5
            anchors.top: parent.top
            anchors.topMargin: 0
            width: parent.width
            height: 50*app.dp
            color: Palette.darkPrimary
            Rectangle {
                id: menuButton
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 1.2*height
                height: parent.height
                scale: maMenuBar.pressed ? 1.2 : 1
                color: "transparent"
                MenuIconLive {
                    id: menuBackIcon
                    scale: (parent.height/height)*0.65
                    anchors.centerIn: parent
                    value: menuProgressOpening
                }
                MouseArea {
                    id: maMenuBar
                    anchors.fill: parent
                    onClicked: onMenu()
                }
                clip: true
            }
            Label {
                id: titleText
                anchors.left: menuButton.right
                anchors.verticalCenter: parent.verticalCenter
                text: appTitle
                font.pixelSize: 0.35*parent.height
                color: Palette.text
            }
        }
        Image {
            id: imgShadow
            anchors.top: menuBar.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 6*app.dp
            z: 4
            source: "qrc:/images/shadow_title.png"
        }


        //*************************************************//
        Rectangle {
            id: menuView
            anchors.top: menuBar.bottom
            height: parent.height - menuBar.height
            width: menuWidth
            z: 3
            MainMenu {
                id: mainMenu
                anchors.fill: parent
                onMenuItemClicked: {
                    onMenu()
                    loader.source = page 
                }
            }
            x: -menuWidth

            Behavior on x { NumberAnimation { duration: app.durationOfMenuAnimation; easing.type: Easing.OutQuad } }
            onXChanged: {
                menuProgressOpening = (1-Math.abs(menuView.x/menuWidth))
            }
        }
        Image {
            id: imgShadowMenu
            anchors.top: menuBar.bottom
            anchors.bottom: menuView.bottom
            anchors.left: menuView.right
            width: 6*app.dp
            z: 5
            source: "qrc:/images/shadow_long.png"
            visible: menuView.x !== -menuWidth
        }
        Rectangle {
            id: curtainMenu
            z: 1
            anchors.fill: parent
            color: "black"
            opacity: app.menuProgressOpening*0.5
        }


        //*************************************************//
        Loader {
            id: loader
            anchors.top: menuBar.bottom;
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            //asynchronous: true
            onStatusChanged: {
                if( status == Loader.Loading ) {
                    curtainLoading.visible = true
                    titleText.text = appTitle
                } else if( status == Loader.Ready ) {
                    curtainLoading.visible = false
                } else if( status == Loader.Error ) {
                    curtainLoading.visible = false
                }
            }
            onLoaded: {
                titleText.text = item.title
            }
            Rectangle {
                id: curtainLoading
                anchors.fill: parent
                visible: false
                color: "white"
                opacity: 0.8
                BusyIndicator {
                    anchors.centerIn: parent
                }
            }
        }
    }

    function onMenu() {
        menuView.x = app.menuIsShown ? -menuWidth : 0
    }

    Component.onCompleted: {
        currentPage = "TasksPage.qml"
        mainMenu.currentItem = 0
    }
}
