import QtQuick 2.12
import QtQuick.Controls 2.12

Page {

    property int fontSize: 20
    property alias btnCreate: btnCreate
    property alias selWidth: tfWidth.text
    property alias selHeight: tfHeight.text
    property alias selColors: tfColors.text

    Column {
        spacing: 20

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 15

        GroupBox {
            id: gbSize
            title: "Sizing"
            anchors.right: parent.right
            anchors.left: parent.left

            Column {
                spacing: 0

                Label {
                    text: qsTr("Width:")
                    color: mainAppColor
                    font.pointSize: fontSize
                }
                TextField {
                    id: tfWidth
                    text: "100"
                    font.pointSize: fontSize
                    validator: IntValidator {bottom: 40; top: 120}

                }

                Label {
                    text: qsTr("Height:")
                    color: mainAppColor
                    font.pointSize: fontSize
                }
                TextField {
                    id: tfHeight
                    text: "100"
                    font.pointSize: fontSize
                    validator: IntValidator {bottom: 40; top: 120}
                }
            }
        }

        GroupBox {
            id: gbColor
            title: "Colorizing"
            anchors.right: parent.right
            anchors.left: parent.left

            Column {
                spacing: 0

                Label {
                    text: qsTr("Max amount of colors:")
                    color: mainAppColor
                    font.pointSize: fontSize
                }
                TextField {
                    id: tfColors
                    text: "20"
                    font.pointSize: fontSize
                    validator: IntValidator {bottom: 5; top: 99}
                }
            }
        }

        GroupBox {
            id: gbFloss
            title: "Flossing"
            anchors.right: parent.right
            anchors.left: parent.left

            Column {
                spacing: 0

                Label {
                    text: qsTr("Floss type:")
                    color: mainAppColor
                    font.pointSize: fontSize
                }

                RadioButton {
                    id: rbDMC
                    text: "DMC"
                    checked: true
                }
                RadioButton {
                    text: "Anchor"
                    enabled: false
                }
                RadioButton {
                    text: "Sullivans"
                    enabled: false
                }
            }
        }

        Button {
            id: btnCreate
            anchors.right: parent.right
            anchors.rightMargin: 10
            width: parent.width * 0.35
            height: 50

            text: "Create"
        }
    }
}
