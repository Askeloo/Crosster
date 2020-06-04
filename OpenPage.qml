import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    ListView {
        id: listView

        anchors.fill: parent
        anchors.margins: 15
        focus: true
        spacing: 5

        boundsBehavior: Flickable.StopAtBounds

        delegate: ItemDelegate {
            Row {
                spacing: 10

                Image {
                    width: height
                    height: parent.height
                    source: model.imgSource
                    sourceSize.width: 100
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                }

                Column {
                    Text {
                        id: name
                        text: model.name
                    }
                    Text {
                        id: size
                        text: model.width + "x" + model.height
                    }
                    Text {
                        id: floss
                        text: model.flossBrand + ", " + model.flosses + "threads"
                    }
                    Text {
                        id: progress
                        text: "Progress: " + model.progress.toFixed(4) + " %"
                        color: "grey"
                    }
                }

                anchors.verticalCenter: parent.verticalCenter
            }
            width: parent.width
            height: 100

            onClicked: {
                stackView.replace("qrc:/PatternPage.qml");
                currentTitle = "Scheme"
            }
        }

        model: ListModel {
            ListElement { imgSource: "qrc:/files/_temp_sun.jpg"; name: "sun"; flossBrand: "DMC";
                width: 100; height: 100; flosses: 38; progress: 0.03012}
            ListElement { imgSource: "qrc:/files/_temp_oleksa.jpg"; name: "oleksa"; flossBrand: "DMC";
                width: 100; height: 133; flosses: 40; progress: 1.3392}
            ListElement { imgSource: "qrc:/files/_temp_lake.jpg"; name: "lake"; flossBrand: "DMC";
                width: 160; height: 100; flosses: 44; progress: 25.043}
        }
    }


    Component.onCompleted: appIsBusy = false
}
