import QtQuick 2.11
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Material 2.12


import Askelo.OpenAndroidGallery 1.0

Page {

    RoundButton {
        id: roundButton

        property bool textIcon: true
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10
        width: 70
        height: 70
        z: 3
        text: textIcon ? "\uf591" : "\uf0b2"
        font.pointSize: 25
        font.family: "fontawesome"

        onClicked:  {
            gb.editMode = !gb.editMode
            roundButton.textIcon = !roundButton.textIcon
            //openG.openGallery()
        }
    }

    GridBoard {
        id: gb
        anchors.fill: parent
    }

}


