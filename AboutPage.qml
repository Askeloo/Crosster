import QtQuick 2.0
import QtQuick.Controls 2.12

Page {
    Column {
        id: aboutColumn
        spacing: 20
        anchors.centerIn: parent

        Label {
            text: "Diploma work made by Oleksa Romanchuk"
            wrapMode: Label.Wrap
            font.pixelSize: 15
        }
    }
}
