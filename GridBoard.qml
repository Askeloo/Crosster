import QtQuick 2.12
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

//import CellTableModel 1.0

Item {
    id: name

    anchors.topMargin: 40
    anchors.bottomMargin: 20
    anchors.leftMargin: 20
    anchors.rightMargin:  20

    property bool editMode: false

    Rectangle {
        id: background
        color: "lightgrey"
        anchors.fill: parent
    }

    PinchArea {
        id: p
        anchors.fill: parent //тут f
        enabled: !editMode
        //pinch.target: i
        pinch.maximumScale: 2
        pinch.minimumScale: width / tblV.contentWidth

        property real initialWidth
        property real initialHeight

        property real prevScale : 1.0

        onPinchStarted: {
            initialWidth = f.contentWidth
            initialHeight = f.contentHeight
            console.debug("PinchStart___" + zoomScale.xScale + "___" + zoomScale.yScale)

            //f.interactive=false;

        }

        onPinchUpdated: {   //FIXME

            f.contentX += pinch.previousCenter.x - pinch.center.x
            f.contentY += pinch.previousCenter.y - pinch.center.y

            var diffscale = pinch.scale - pinch.previousScale;
            var newscale = prevScale + diffscale;
            if (newscale >= width / tblV.contentWidth && newscale <= 2.0)
            {
                prevScale += diffscale;
                zoomScale.xScale = prevScale;
                zoomScale.yScale = prevScale;

                //zoomScale.origin.x = iContainer.width / 2;
                //zoomScale.origin.y = iContainer.height / 2;

                //console.debug("___" + zoomScale.xScale + "___" + zoomScale.yScale)
            }

            //f.resizeContent(initialWidth * pinch.scale, initialHeight * pinch.scale, pinch.center)
        }

        onPinchFinished: {
            //prevScale = pinch.scale
            //console.debug("PinchEnd")
            //f.interactive=true;
            //f.returnToBounds();
        }
        Flickable {
            id: f
            anchors.fill: parent
            //boundsBehavior: Flickable.StopAtBounds
            contentHeight: tblV.contentHeight
            contentWidth: tblV.contentWidth
            clip: true
            interactive: false

            contentX: (contentWidth - width) / 2;
            contentY: (contentHeight - height) / 2;

            Item {
                id: iContainer
                width: tblV.contentWidth
                height: tblV.contentHeight



                TableView {
                    id: tblV
                    z: 5
                    //anchors.fill: parent

                    implicitWidth:  tblV.contentWidth
                    implicitHeight:  tblV.contentHeight
                    //anchors.fill: parent
                    //x: (width)
                    //y: (height)
                    rowSpacing: 0
                    columnSpacing: 0
                    //scale: p.width / contentWidth  //тут

                    interactive: false

                    delegate: Rectangle {
                        id: cellRect
                        implicitWidth: 15
                        implicitHeight: 15

                        color: cell.checked ? "red" : "lightgreen"
                        //opacity: cell.checked ? 1 : 0.33

                        MouseArea {
                            //z: 4
                            anchors.fill: parent
                            enabled: editMode
                            onPressed:  cell.checked = !cell.checked
                        }

                        Text {
                            id: symbol
                            visible: p.prevScale > 0.5
                            font.pixelSize: 10
                            anchors.centerIn: parent
                            text: cell.symbol
                        }
                    }

                    model: guiManager.cell_model
//                        CellTableModel {
//                        id: cellModel
//                    }

                    clip: true

                    Component.onCompleted: {
                        zoomScale.origin.x = iContainer.width / 2;
                        zoomScale.origin.y = iContainer.height / 2;
                        p.prevScale = p.width / tblV.contentWidth;
                        zoomScale.xScale = p.prevScale;
                        zoomScale.yScale = p.prevScale;
                    }

                    Canvas {
                        id: lines
                        z : 7
                        anchors.fill: parent
                        property real wgrid: 15
                        onPaint: {
                            var ctx = getContext("2d")
                            ctx.lineWidth = 1
                            ctx.strokeStyle = "black"
                            ctx.beginPath()

//                            var ctx2 = getContext("2d")
//                            ctx2.lineWidth = 0.4
//                            ctx2.strokeStyle = "grey"
//                            ctx2.beginPath()
                            var nrows = (height/wgrid);
                            for(var i=0; i < nrows+1; i++){
                                if(i%10 === 0)
                                {
                                    var ki = wgrid*i - 0.5;
                                    ctx.moveTo(0, ki);
                                    ctx.lineTo(width, ki);
                                }
//                                else
//                                {
//                                    var ki2 = wgrid*i - 0.2;
//                                    ctx2.moveTo(0, ki2);
//                                    ctx2.lineTo(width, ki2);
//                                }
                            }

                            var ncols = (width/wgrid);
                            for(var j=0; j < ncols+1; j++){
                                if(j%10 === 0)
                                {
                                    var kj = wgrid*j - 0.5;
                                    ctx.moveTo(kj, 0);
                                    ctx.lineTo(kj, height);
                                }
//                                else
//                                {
//                                    var kj2 = wgrid*j - 0.2;
//                                    ctx2.moveTo(kj2, 0);
//                                    ctx2.lineTo(kj2, height);
//                                }
                            }
                            ctx.closePath()
                            ctx.stroke()
                        }

                    }

                    Canvas {
                        id: lines2
                        z : 6
                        visible:  p.prevScale > 0.5
                        anchors.fill: parent
                        property real wgrid: 15
                        onPaint: {
                            var ctx2 = getContext("2d")
                            ctx2.lineWidth = 0.4
                            ctx2.strokeStyle = "grey"
                            ctx2.beginPath()
                            var nrows = (height/wgrid);
                            for(var i=0; i < nrows+1; i++){
                                if(i%10 !== 0)
                                {
                                    var ki2 = wgrid*i - 0.2;
                                    ctx2.moveTo(0, ki2);
                                    ctx2.lineTo(width, ki2);
                                }
                            }

                            var ncols = (width/wgrid);
                            for(var j=0; j < ncols+1; j++){
                                if(j%10 !== 0)
                                {
                                    var kj2 = wgrid*j - 0.2;
                                    ctx2.moveTo(kj2, 0);
                                    ctx2.lineTo(kj2, height);
                                }
                            }
                            ctx2.closePath()
                            ctx2.stroke()
                        }
                    }
                }


                transform: [
                    Scale {
                        id: zoomScale

                        //origin.x : iContainer.width / 2;
                        //origin.y : iContainer.height / 2;

                        //origin.x: p.prevScale * iContainer.width / 2
                        //origin.y: p.prevScale * iContainer.height / 2
                    },
                    Translate {
                        id: zoomTranslate
                    }

                ]


            }
        }

    }


}


/*
Item {
    id: name

    anchors.topMargin: 50
    anchors.bottomMargin: 20
    anchors.leftMargin: 20
    anchors.rightMargin:  20

    property bool editMode: false

    Rectangle {
        id: background
        color: "lightgrey"
        anchors.fill: parent
    }
//   Flickable {
//        anchors.fill: parent
//        interactive: !editMode

//        contentHeight: tblV.height;
//        contentWidth: tblV.width;

    PinchArea {
        id: p
        //z: 3
        //width: 5000
        //height: 5000
        //anchors.centerIn: parent
        anchors.fill: parent
        //enabled: i.status === Image.Ready
        enabled: !editMode
        pinch.target: grid
        pinch.maximumScale: 2
        pinch.minimumScale: width / tblV.contentWidth // 1
        pinch.dragAxis: Pinch.XAndYAxis        

        property real initialWidth
        property real initialHeight

        //scale: 0.3
        onPinchStarted: {
            console.debug("PinchStart")
            initialWidth = tblV.contentWidth
            initialHeight = tblV.contentHeight
            //tblV.interactive=false;
            //pinch.accepted = true
        }

        onPinchUpdated: {
            tblV.resizeContent(initialWidth * pinch.scale, initialHeight * pinch.scale, pinch.center)
            //tblV.contentItem.scale -= pinch.previousScale - pinch.scale;
            //tblV.contentX += pinch.previousCenter.x - pinch.center.x
           // tblV.contentY += pinch.previousCenter.y - pinch.center.y
            //tblV.contentItem.positionChanged(pinch);

//            console.debug("_________start__________")
//            console.debug("cw____" + tblV.contentWidth)
//            console.debug("ch____" + tblV.contentHeight)
//            console.debug("w____" + tblV.width)
//            console.debug("h____" + tblV.height)
//            console.debug("pw____" + width)
//            console.debug("ph____" + height)
//            console.debug("pcentr____" + pinch.center)
//            console.debug("_________end__________")

        }

        onPinchFinished: {
            console.debug("PinchEnd")
            //tblV.interactive=true;
            tblV.returnToBounds();
        }

        Item {
            id: grid

            implicitWidth: tblV.contentWidth
            implicitHeight: tblV.contentHeight
            //anchors.topMargin: 50
            //anchors.bottomMargin: 20
            //anchors.leftMargin: 20
            //anchors.rightMargin:  20

            onScaleChanged: console.debug("scale changed")


            //x: p.x - (width / 2)
            //y: p.y - (height / 2)

            Canvas {
                id: lines
                anchors.fill: parent
                property int wgrid: 16
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.lineWidth = 1
                    ctx.strokeStyle = "black"
                    ctx.beginPath()
                    var nrows = (height/wgrid);
                    for(var i=0; i < nrows+1; i++){
                        if(i%10 === 0)
                        {
                            var ki = wgrid*i - 0.5;
                            ctx.moveTo(0, ki);
                            ctx.lineTo(width, ki);
                        }
                    }

                    var ncols = (width/wgrid);
                    for(var j=0; j < ncols+1; j++){
                        if(j%10 === 0)
                        {
                            var kj = wgrid*j - 0.5;
                            ctx.moveTo(kj, 0);
                            ctx.lineTo(kj, height);
                        }
                    }
                    ctx.closePath()
                    ctx.stroke()
                }
            }


                TableView {
                    id: tblV
                    //z: 2
                    //anchors.fill: parent

                    implicitWidth: tblV.contentWidth
                    implicitHeight: tblV.contentHeight
                    //anchors.fill: parent
                    //x: (width)
                    //y: (height)
                    //ena
                    rowSpacing: 1
                    columnSpacing: 1
                    //scale: p.width / contentWidth  //тут

                    interactive: false

                    delegate: Rectangle {
                        id: cell
                        implicitWidth: 15
                        implicitHeight: 15

                        color: model.value ? "red" : "lightgreen"

                        MouseArea {
                            //z: 4
                            anchors.fill: parent
                            enabled: editMode
                            onPressed:  model.value = !model.value
                        }
                    }

                    model: CellTableModel {
                        id: cellModel
                    }

                    //contentX: (contentWidth - width) / 2;
                    //contentY: (contentHeight - height) / 2;

                    //Scaling
                    //boundsBehavior: Flickable.StopAtBounds
                    //boundsMovement: Flickable.StopAtBounds
                    clip: true
                    //scale: 1




                    property bool fitToScreenActive: true

                    property real minZoom: 0.1;
                    property real maxZoom: 2

                    property real zoomStep: 0.1

                    property real prevScale: 1.0;

//                    onWidthChanged: {
//                        if (fitToScreenActive)
//                            fitToScreen();
//                    }
//                    onHeightChanged: {
//                        if (fitToScreenActive)
//                            fitToScreen();
//                    }

                    //smooth: moving
                    //transformOrigin: Item.Center

                    onScaleChanged: {
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

    Component.onCompleted: console.debug("completed")//f.fitToScreen();


    //}
}
*/
//---------------------------------------------------------------------
/*
Item {
    id: name

    anchors.topMargin: 40
    anchors.bottomMargin: 20
    anchors.leftMargin: 20
    anchors.rightMargin:  20

    property bool editMode: false

    Rectangle {
        id: background
        color: "lightgrey"
        anchors.fill: parent
    }

    Flickable {
        id: f
        anchors.fill: parent
        //boundsBehavior: Flickable.StopAtBounds
        contentHeight: iContainer.height;
        contentWidth: iContainer.width;
        clip: true
        interactive: false

//        onContentXChanged: console.debug("CX"+contentX)
//        onContentYChanged: console.debug("CY"+contentY)

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

        PinchArea {
            id: p
            anchors.fill: parent //тут f
            //enabled: i.status === Image.Ready
            //pinch.target: i
            pinch.maximumScale: 2
            pinch.minimumScale: width / tblV.contentWidth

            property real initialWidth
            property real initialHeight

            onPinchStarted: {
                initialWidth = f.contentWidth
                initialHeight = f.contentHeight
                //console.debug("PinchStart")
                //f.interactive=false;

            }

            onPinchUpdated: {
                f.contentX += pinch.previousCenter.x - pinch.center.x
                f.contentY += pinch.previousCenter.y - pinch.center.y

                zoomScale.origin.x = pinch.center.x;
                zoomScale.origin.y = pinch.center.y;
                zoomScale.xScale = pinch.scale;
                zoomScale.yScale = pinch.scale;
                //f.resizeContent(initialWidth * pinch.scale, initialHeight * pinch.scale, pinch.center)

                console.debug("PW___" + p.width)
                console.debug("PH___" + p.height)
            }

            onPinchFinished: {
                //console.debug("PinchEnd")
                //f.interactive=true;
                //f.returnToBounds();
            }

        Item {
            id: iContainer
            width: Math.max(i.width * i.scale, f.width)
            height: Math.max(i.height * i.scale, f.height)

            transform: [
                Scale {
                    id: zoomScale
                },
                Translate {
                    id: zoomTranslate
                }

            ]

            Item {
                id: i

                property real prevScale: 1.0;

                implicitWidth: tblV.contentWidth
                implicitHeight: tblV.contentHeight


                //anchors.topMargin: 50
                //anchors.bottomMargin: 20
                //anchors.leftMargin: 20
                //anchors.rightMargin:  20

                //x: p.x - (width / 2)
                //y: p.y - (height / 2)

//                Canvas {
//                    id: lines
//                    anchors.fill: parent
//                    property int wgrid: 16
//                    onPaint: {
//                        var ctx = getContext("2d")
//                        ctx.lineWidth = 1
//                        ctx.strokeStyle = "black"
//                        ctx.beginPath()

////                        var ctx2 = getContext("2d")
////                        ctx2.lineWidth = 0.4
////                        ctx2.strokeStyle = "grey"
////                        ctx2.beginPath()
//                        var nrows = (height/wgrid);
//                        for(var i=0; i < nrows+1; i++){
//                            if(i%10 === 0)
//                            {
//                                var ki = wgrid*i - 0.5;
//                                ctx.moveTo(0, ki);
//                                ctx.lineTo(width, ki);
//                            }
////                            else
////                            {
////                                var ki2 = wgrid*i - 0.2;
////                                ctx2.moveTo(0, ki2);
////                                ctx2.lineTo(width, ki2);
////                            }
//                        }

//                        var ncols = (width/wgrid);
//                        for(var j=0; j < ncols+1; j++){
//                            if(j%10 === 0)
//                            {
//                                var kj = wgrid*j - 0.5;
//                                ctx.moveTo(kj, 0);
//                                ctx.lineTo(kj, height);
//                            }
////                            else
////                            {
////                                var kj2 = wgrid*j - 0.2;
////                                ctx2.moveTo(0, kj2);
////                                ctx2.lineTo(width, kj2);
////                            }
//                        }
//                        ctx.closePath()
//                        ctx.stroke()
//                    }
//                }


                TableView {
                    id: tblV
                    //z: 2
                    //anchors.fill: parent

                    //implicitWidth:  tblV.contentWidth
                    //implicitHeight:  tblV.contentHeight
                    anchors.fill: parent
                    //x: (width)
                    //y: (height)
                    rowSpacing: 1
                    columnSpacing: 1
                    //scale: p.width / contentWidth  //тут

                    interactive: false

                    delegate: Rectangle {
                        id: cell
                        implicitWidth: 15
                        implicitHeight: 15

                        color: model.value ? "red" : "lightgreen"

                        MouseArea {
                            //z: 4
                            anchors.fill: parent
                            enabled: editMode
                            onPressed:  model.value = !model.value
                        }
                    }

                    model: CellTableModel {
                        id: cellModel
                    }

                    clip: true

                }
                onScaleChanged: {
                    //console.debug("Scale__" + scale)
//                    if ((width * scale) > f.width) {
//                        var xoff = (f.width / 2 + f.contentX) * scale / prevScale;
//                        f.contentX = xoff - f.width / 2
//                    }
//                    if ((height * scale) > f.height) {
//                        var yoff = (f.height / 2 + f.contentY) * scale / prevScale;
//                        f.contentY = yoff - f.height / 2
//                    }
//                    prevScale=scale;
                }

            }
        }

        }
        function fitToScreen() {
            var s = Math.min(f.width / i.width, f.height / i.height, 1)
            i.scale = s;
            f.minZoom = s;
            i.prevScale = scale
            fitToScreenActive=true;
            f.returnToBounds();
        }

//        ScrollIndicator.vertical: ScrollIndicator { }
//        ScrollIndicator.horizontal: ScrollIndicator { }

    }



    Component.onCompleted: f.fitToScreen();

}

*/

//---------------------------------------------------------

