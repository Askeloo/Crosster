import QtQuick 2.12
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

//import CellTableModel 1.0

Item {
    id: name

    anchors.fill: parent
    property bool editMode: false
    property bool showSymbols: false

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

            showSymbols = false
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
            showSymbols = true
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
                        color: cell.checked ? "red" : (cell.highlighted ? "orange" : cell.color)
                        //opacity: cell.checked ? 0.33 : 1


                        MouseArea {
                            //z: 4
                            anchors.fill: parent
                            //enabled: editMode
                            onPressed: {
                                if(editMode) {
                                    cell.checked = !cell.checked
                                }
                            }
                            onPressAndHold: {
                                 if(!editMode) {
                                    guiManager.highlight(cell.color)
                                }
                            }

                            //onPressAndHold: cellRect.color = "green"
                            //onDoubleClicked: cellRect.color = "blue"
                        }

                        Text {
                            id: symbol
                            visible: (p.prevScale > 0.5) && showSymbols
                            font.pixelSize: 10
                            anchors.centerIn: parent
                            text: cell.symbol
                            color: ((cellRect.color.r + cellRect.color.g + cellRect.color.b) / 3 < 0.5) ? "white" : "black"
                        }
                    }

                    model: guiManager.cell_model

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
