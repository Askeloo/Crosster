import QtQuick 2.4
import QtQuick.Controls 2.3

Page {
    id: page
    property alias roundButton: roundButton
    property alias image: image

    Rectangle {
        id: rectangle
        width: parent
        height: parent
        color: "#e29414"
    }

    RoundButton {
        id: roundButton
        x: parent.width - 50
        y: parent.height - 50
        text: "+"
        font.pointSize: 12
        font.family: "FontAwesome"
    }

    Image {
        id: image
        anchors.centerIn: parent
        width: 400
        height: 300
        sourceSize.width: 1024
        sourceSize.height: 768
        fillMode: Image.PreserveAspectFit
        source: "qrc:/qtquickplugin/images/template_image.png"
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

