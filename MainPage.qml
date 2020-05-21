import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2

import Apadana.OpenAndroidGallery 1.0

MainPageForm {
    anchors.fill: parent

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

    GridBoard {
        anchors.fill: parent
    }

    OpenAndroidGallery{
        id: openG
        onSigSendPath: image.source = "file://" + path
    }

    roundButton.onClicked:
    {
        openG.openGallery()
    }


}


