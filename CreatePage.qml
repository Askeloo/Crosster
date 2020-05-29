import QtQuick 2.12
import QtQuick.Controls 2.12


import Askelo.OpenAndroidGallery 1.0

Page {
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        TabPage1 {
            id: tp1

            chP.onClicked: {
                openG.openGallery()
            }
        }

        TabPage2 {
            id: tp2

            btnCreate.onClicked: createDialog.open()
        }

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: "Image"
        }
        TabButton {
            text: "Properties"
        }
    }

    Component.onCompleted: {
        openG.openGallery()
    }

    OpenAndroidGallery{
        id: openG
        onSigSendPath: tp1.img.source = "file://" + path
    }

    Dialog {
        id: createDialog
        modal: true
        focus: true
        title: "Create pattern"
        x: (window.width - width) / 2
        y: window.height / 4
        width: Math.min(window.width, window.height) / 3 * 2
        contentHeight: aboutColumn.height

        standardButtons: Dialog.Ok

        Column {
            id: aboutColumn
            spacing: 0

            TextField {
                width: createDialog.availableWidth
                text: "NewPattern"
                wrapMode: Label.Wrap
                font.pixelSize: 13
            }
        }
        onAccepted: {
            stackView.replace("qrc:/PatternPage.qml");
            currentTitle = "Scheme"
        }
    }
}
