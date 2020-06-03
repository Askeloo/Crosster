import QtQuick 2.0
import QtQuick.Controls 2.12

Page {
    property int fontSize: 25

    Column {
        id: aboutColumn
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        Label {
            height: 40
            verticalAlignment: Qt.AlignVCenter
            text: guiManager.name
            wrapMode: Label.Wrap
            font.pixelSize: fontSize
            font.bold: true
        }

            Label {
                height: 40
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



            Label {
                height: 40
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



            Label {
                height: 40
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



            Label {
                height: 40
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
