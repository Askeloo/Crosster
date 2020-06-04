import QtQuick 2.0
import QtQuick.Controls 2.12

Page {
    //anchors.fill: parent
    property alias chP: chP
    property alias img: image

    Button {
        id: chP
        anchors.top: parent.top
        //anchors.bottom: image.top
        anchors.topMargin: 20
        anchors.horizontalCenter:  parent.horizontalCenter
        width: parent.width * 0.75
        height: 50

        text: "Change photo"
    }

    Image {
        id: image
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.rightMargin: 5
//        anchors.centerIn: parent
//        width: parent.width - 10
//        height: width

        anchors.horizontalCenter: parent.horizontalCenter

        sourceSize.width: 1024
        fillMode: Image.PreserveAspectFit

        onStatusChanged:  {
            if(image.status == Image.Ready)
            {
                sideRelation = paintedWidth / paintedHeight
            }
        }
    }

}
