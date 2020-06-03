import QtQuick 2.0
import QtQuick.Controls 2.12

Page {
    property int fontSize: 25

    Column {
        id: infoColumn
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        Label {
            height: 40
            //anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Qt.AlignVCenter
            text: guiManager.name
            wrapMode: Label.Wrap
            font.pixelSize: fontSize
            font.bold: true
        }

        Item {
            width: parent.width
            height: 40
            Label {
                anchors.left: parent.left
                text: "Size"
                wrapMode: Label.Wrap
                font.pixelSize: fontSize
            }
            Text {
                anchors.right: parent.right
                text: guiManager.width + "x" + guiManager.height
                font.pixelSize: fontSize
                color: "grey"
            }
        }


        Item {
            width: parent.width
            height: 40
            Label {
                anchors.left: parent.left
                text: "Floss brand"
                wrapMode: Label.Wrap
                font.pixelSize: fontSize


            }
            Text {
                anchors.right: parent.right
                text: guiManager.flossBrand
                font.pixelSize: fontSize
                color: "grey"
            }
        }

        Item {
            width: parent.width
            height: 40
            Label {
                anchors.left: parent.left
                text: "Threads amount"
                wrapMode: Label.Wrap
                font.pixelSize: fontSize
            }
            Text {
                anchors.right: parent.right
                text: guiManager.threadsAmount
                font.pixelSize: fontSize
                color: "grey"
            }
        }


        Item {
            width: parent.width
            height: 40
            Label {
                anchors.left: parent.left
                text: "Progress"
                wrapMode: Label.Wrap
                font.pixelSize: fontSize
            }
            Text {
                anchors.right: parent.right
                text: guiManager.progress + " %"
                font.pixelSize: fontSize
                color: "grey"
            }
        }

    }
}
