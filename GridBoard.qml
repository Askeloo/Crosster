import QtQuick 2.12
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import CellTableModel 1.0

Item {
    id: name

    anchors.topMargin: 50
    anchors.bottomMargin: 20
    anchors.leftMargin: 20
    anchors.rightMargin:  20

    Rectangle {
        id: background
        color: "lightgrey"
        anchors.fill: parent
    }

    PinchArea {
        id: p
        //z: 3
        anchors.fill: parent
        //enabled: i.status === Image.Ready
        pinch.target: tblV.contentItem
        pinch.maximumScale: 2
        pinch.minimumScale: 0.3 //width / tblV.contentWidth
        //scale: pinch.minimumScale
        onPinchStarted: {
            console.debug("PinchStart")
            //tblV.interactive=false;
            //pinch.accepted = true
            console.debug("w_____" + width)
            console.debug("cw____" + tblV.contentWidth)
            console.debug("h_____" + height)
            console.debug("ch____" + tblV.contentHeight)
            console.debug("minimumScale__" + width / tblV.contentWidth)
        }

        onPinchUpdated: {
            //tblV.contentItem.scale -= pinch.previousScale - pinch.scale;
            tblV.contentX += pinch.previousCenter.x - pinch.center.x
            tblV.contentY += pinch.previousCenter.y - pinch.center.y
        }

        onPinchFinished: {
            console.debug("PinchEnd")
            //tblV.interactive=true;
            //tblV.returnToBounds();
        }


        TableView {
            id: tblV
            //z: 2
            anchors.fill: parent

            rowSpacing: 1
            columnSpacing: 1

            interactive: false

            delegate: Rectangle {
                id: cell
                implicitWidth: 15
                implicitHeight: 15

                color: model.value ? "red" : "blue"

                MouseArea {
                    //z: 4
                    anchors.fill: parent
                    onClicked: model.value = !model.value
                }
            }

            model: CellTableModel {
                id: cellModel
            }

            //contentX: (contentWidth - width) / 2;
            //contentY: (contentHeight - height) / 2;

            //Scaling
            //boundsBehavior: Flickable.StopAtBounds
            clip: true
            //scale: 1

            property bool fitToScreenActive: true

            property real minZoom: 0.1;
            property real maxZoom: 2

            property real zoomStep: 0.1

            property real prevScale: 1.0;
            /*
            onWidthChanged: {
                if (fitToScreenActive)
                    fitToScreen();
            }
            onHeightChanged: {
                if (fitToScreenActive)
                    fitToScreen();
            }
            */
            smooth: moving
            transformOrigin: Item.Center

            onScaleChanged: {/*
                console.debug("_________start__________")
                console.debug("Scale______" + scale)

                if ((contentWidth * scale) > width) {
                    var xoff = (width / 2 + contentX) * scale / prevScale;
                    contentX = xoff - width / 2
                }
                if ((contentHeight * scale) > height) {
                    var yoff = (height / 2 + contentY) * scale / prevScale;
                    contentY = yoff - height / 2
                }
                prevScale=scale;
                //console.debug("width_____" + contentWidth)
                //console.debug("height____" + contentHeight)
                console.debug("width___" + width)
                console.debug("height__" + height)
                console.debug("_______________")

                console.debug("prevScale__" + prevScale)
                console.debug("contentX__" + contentX)
                console.debug("contentY__" + contentY)
                console.debug("xoff__" + xoff)
                console.debug("yoff__" + yoff)
                console.debug("_________end__________")
                */
            }

            function fitToScreen() {
                var s = Math.min(width / contentWidth, height / contentHeight, 1)
                console.debug("w_____" + width)
                console.debug("cw____" + contentWidth)
                console.debug("h_____" + height)
                console.debug("ch____" + contentHeight)
                console.debug("ssss__" + s)
                scale = s;
                minZoom = s;
                prevScale = scale
                fitToScreenActive=true;
                returnToBounds();
            }

            //ScrollIndicator.vertical: ScrollIndicator { }
            //ScrollIndicator.horizontal: ScrollIndicator { }
        }


    }
}


/*
Page {
    anchors.fill: parent
    Flickable {
        id: f
        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        contentHeight: iContainer.height;
        contentWidth: iContainer.width;
        clip: true

        onContentXChanged: console.debug("CX"+contentX)
        onContentYChanged: console.debug("CY"+contentY)

        //Behavior on contentY { NumberAnimation {} }
        //Behavior on contentX { NumberAnimation {} }

        property bool fitToScreenActive: true

        property real minZoom: 0.1;
        property real maxZoom: 2

        property real zoomStep: 0.1

        onWidthChanged: {
            if (fitToScreenActive)
                fitToScreen();
        }
        onHeightChanged: {
            if (fitToScreenActive)
                fitToScreen();
        }

        Item {
            id: iContainer
            width: Math.max(i.width * i.scale, width)
            height: Math.max(i.height * i.scale, height)

            Image {
                id: i

                property real prevScale: 1.0;

                asynchronous: true
                cache: false
                smooth: moving
                source: "test.jpg"
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                onWidthChanged: console.debug(width)
                onHeightChanged: console.debug(height)
                transformOrigin: Item.Center
                onScaleChanged: {
                    console.debug(scale)
                    if ((width * scale) > width) {
                        var xoff = (width / 2 + contentX) * scale / prevScale;
                        contentX = xoff - width / 2
                    }
                    if ((height * scale) > height) {
                        var yoff = (height / 2 + contentY) * scale / prevScale;
                        contentY = yoff - height / 2
                    }
                    prevScale=scale;
                }
                onStatusChanged: {
                    if (status===Image.Ready) {
                        fitToScreen();
                    }
                }
                //Behavior on scale { ScaleAnimator { } }
            }
        }
        function fitToScreen() {
            var s = Math.min(width / i.width, height / i.height, 1)
            i.scale = s;
            minZoom = s;
            i.prevScale = scale
            fitToScreenActive=true;
            returnToBounds();
        }
        function zoomIn() {
            if (scale<maxZoom)
                i.scale*=(1.0+zoomStep)
            returnToBounds();
            fitToScreenActive=false;
            returnToBounds();
        }
        function zoomOut() {
            if (scale>minZoom)
                i.scale*=(1.0-zoomStep)
            else
                i.scale=minZoom;
            returnToBounds();
            fitToScreenActive=false;
            returnToBounds();
        }
        function zoomFull() {
            i.scale=1;
            fitToScreenActive=false;
            returnToBounds();
        }


        ScrollIndicator.vertical: ScrollIndicator { }
        ScrollIndicator.horizontal: ScrollIndicator { }

    }

    PinchArea {
        id: p
        anchors.fill: f
        enabled: i.status === Image.Ready
        pinch.target: i
        pinch.maximumScale: 2
        pinch.minimumScale: 0.1
        onPinchStarted: {
            console.debug("PinchStart")
            interactive=false;
        }

        onPinchUpdated: {
            contentX += pinch.previousCenter.x - pinch.center.x
            contentY += pinch.previousCenter.y - pinch.center.y
        }

        onPinchFinished: {
            console.debug("PinchEnd")
            interactive=true;
            returnToBounds();
        }
    }

}
*/
