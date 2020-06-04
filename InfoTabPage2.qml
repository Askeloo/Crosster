import QtQuick 2.0
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
                Text {
                    id: symb
                    text: model.symbol
                    width: 20
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle {
                    color: model.color
                    anchors.margins: 10
                    width: 80
                    height: 40
                    anchors.verticalCenter: parent.verticalCenter
                    //border.color: "black"
                    //border.width: 2
                }

                Column {
                    Text {
                        id: code
                        text: model.code
                    }
                    Text {
                        id: desc
                        text: model.description
                    }
                    Text {
                        id: amount
                        text: model.amount + " stitches"
                        color: "grey"
                    }
                }
            }

            width: parent.width
            height: 60
            onClicked: {

            }
        }

        model: ListModel {
            ListElement { symbol: "X"; color: "#6B9EBF";
                code: "826"; description: "Blue Medium"; amount: 11282 }
            ListElement { symbol: "O"; color: "#6BDCBCB";
                code: "927"; description: "Gray Green Light"; amount: 7822 }
            ListElement { symbol: "~"; color: "#889268";
                code: "3052"; description: "Green Gray Md"; amount: 5143 }
            ListElement { symbol: "*"; color: "#555B7B";
                code: "792"; description: "Cornflower Blue Dark"; amount: 4282 }
            ListElement { symbol: "+"; color: "#4F4B41";
                code: "3021"; description: "Brown Gray Vy Dk"; amount: 3383 }
        }
    }
}
