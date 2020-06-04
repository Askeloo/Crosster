import QtQuick 2.12
import QtQuick.Controls 2.12


import Askelo.OpenAndroidGallery 1.0

Page {

    property string imgPath: ""
    property real sideRelation: 1 //width to height

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        CreateTabPage1 {
            id: tp1

            chP.onClicked: {
                openG.openGallery()
            }
        }

        CreateTabPage2 {
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
        appIsBusy = false
        openG.openGallery()
    }

    OpenAndroidGallery{
        id: openG
        onSigSendPath: {
            imgPath = path;
            tp1.img.source = "file://" + path
        }
    }

    Dialog {
        id: createDialog
        modal: true
        focus: true
        title: "Create pattern"
        x: (window.width - width) / 2
        y: window.height / 4
        width: Math.min(window.width, window.height) / 3 * 2
        contentHeight: infoColumn.height

        standardButtons: Dialog.Ok

        Column {
            id: infoColumn
            spacing: 0

            TextField {
                id: tfName
                width: createDialog.availableWidth
                text: "NewPattern"
                wrapMode: Label.Wrap
                font.pixelSize: 13
            }
        }
        onAccepted: {
            guiManager.name = tfName.text;
            guiManager.imagePath = imgPath;
            guiManager.flossBrand = "DMC"; //FIXME
            guiManager.width = tp2.selWidth;
            guiManager.height = tp2.selHeight;
            guiManager.maxColors = tp2.selColors;

            guiManager.createPattern();
            stackView.replace("qrc:/PatternPage.qml");
            currentTitle = "Scheme"
        }
    }
}
