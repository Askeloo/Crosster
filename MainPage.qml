import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

import Apadana.OpenAndroidGallery 1.0

MainPageForm {

    ToolButton {
        id: menuButton
        y: 12
        x: 2
        z: 1
        height: 32
        width: height

        onClicked: {
            drawer.open()
        }

        Text {
            x: menuButton.x
            y: 2
            text: "\uf0c9"
            font.pointSize: 20
            font.family: "fontawesome"
            color: backGroundColor

        }

        background: Rectangle {
            color: friendListColor
        }
    }

    Drawer {
        id: drawer
        width: 0.33 * parent.width
        height: parent.height

        Label {
            text: "Content goes here!"
            anchors.centerIn: parent
        }
        background: Rectangle {
            color: friendListColor
        }
    }

    OpenAndroidGallery{
        id: openG
        onSigSendPath: image.source = "file://" + path
    }

    roundButton.onClicked:
    {
        openG.openGallery()
    }

        /*Drawer {
            id: drawer
            width: window.width /2
            height: window.height
            background: Rectangle {
                color: friendListColor

                Rectangle {
                    x: 0
                    y: 320
                    width: parent.width
                    height: parent.height
                    id: friendReqButton
                    color: friendMouseAreaColor

                    Text {
                        text: "\uf007"
                        font.pointSize: 15
                        font.family: "fontawesome"
                        color: backGroundColor
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 5

                        Text {
                            text: guiManager.unread_requests ? guiManager.unread_requests : ""
                            color: friendListColor
                            font.pointSize: 5
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            clip: false
                            Rectangle {
                                z: -1
                                height: parent.height + 5
                                width: (parent.width == 0) ? 0 : (parent.width < parent.height) ? parent.height + 7 : parent.width + 7 //  =)
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: borderColor
                                radius: width
                            }
                        }
                    }

                    Text {
                        text: "Friend requests"
                        font.bold: true
                        color: backGroundColor
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                    }

                    MouseArea {
                        id: friendReqMA
                        anchors.fill: parent
                    }

                    Dialog {
                        id: friendRequestDialog
                        title: "Friend requests"
                        background: Rectangle {
                            color: friendListColor
                            border.color: friendMouseAreaColor
                            anchors.verticalCenter: window.verticalCenter
                        }
                        modal: true
                        height: 300
                        width: 250
                        x: (window.width - width) / 2
                        y: (window.height - height) / 2
                        parent: ApplicationWindow.overlay

                        ListView {
                            id: friendRequestList
                            anchors.fill: parent
                            highlightRangeMode: ListView.ApplyRange
                            flickableDirection: Flickable.VerticalFlick
                            boundsBehavior: Flickable.StopAtBounds
                            orientation: ListView.Vertical
                        }
                    }
                }
                Rectangle {
                    x: 0
                    y: 350
                    width: friendList.width
                    id: editProfileButton
                    height: 30
                    color: friendMouseAreaColor

                    Text {
                        text: "\uf044"
                        font.pointSize: 15
                        font.family: "fontawesome"
                        color: backGroundColor
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                    }

                    Text {
                        text: "Edit profile"
                        font.bold: true
                        color: backGroundColor
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                    }
                    MouseArea {
                        id: editProfileMA
                        anchors.fill: parent
                    }

                    Menu {
                        id: editProfileMenu
                        y: findButton.height

                        MenuItem {
                            text: "New..."
                        }
                        MenuItem {
                            text: "Open..."
                        }
                        MenuItem {
                            text: "Save"
                        }
                    }
                }
                Rectangle {
                    x: 0
                    y: 380
                    width: friendList.width
                    id: settingsButton
                    height: 30
                    color: friendMouseAreaColor

                    Text {
                        text: "\uf013"
                        font.pointSize: 15
                        font.family: "fontawesome"
                        color: backGroundColor
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                    }

                    Text {
                        text: "Settings"
                        font.bold: true
                        color: backGroundColor
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                    }

                    MouseArea {
                        id: settingsMA
                        anchors.fill: parent
                    }

                    Menu {
                        id: settingsMenu
                        y: findButton.height

                        MenuItem {
                            text: "New..."
                        }
                        MenuItem {
                            text: "Open..."
                        }
                        MenuItem {
                            text: "Save"
                        }
                    }
                }

            }
        }*/

}


