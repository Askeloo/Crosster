import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    property alias btnCreate: btnCreate
    property alias selWidth: tfWidth.text
    property alias selHeight: tfHeight.text
    property alias selColors: tfColors.text
    property alias dmcChecked: rbDMC.checked

    property int fontSize: 15
    property bool currentEdit: true  //for editing other side without loop to current

    Column {
        spacing: 12

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
                width: parent.width

                Label {
                    text: qsTr("Width:")
                    color: mainAppColor
                    font.pointSize: fontSize
                }

                Item {
                    width: parent.width
                    height: tfWidth.height
                    TextField {
                        id: tfWidth
                        text: Math.round(100)
                        font.pointSize: fontSize

                        validator: IntValidator {bottom: widthBottom; top: widthTop}
                        color: (acceptableInput) ? mainColor : "red"

                        onTextEdited:  {
                            if(currentEdit)
                            {
                                tfHeight. text = Math.round(text / sideRelation)
                            }
                            currentEdit != currentEdit
                        }
                    }

                    Text {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter

                        font.pointSize: fontSize
                        text: qsTr("Width range: [" + widthBottom + ";" + widthTop + "]")
                        color: "red"
                        visible: !tfWidth.acceptableInput
                    }
                }

                Label {
                    text: qsTr("Height:")
                    color: mainAppColor
                    font.pointSize: fontSize
                }

                Item {
                    width: parent.width
                    height: tfHeight.height
                    TextField {
                        id: tfHeight
                        text: Math.round(tfWidth.text / sideRelation)
                        font.pointSize: fontSize

                        validator: IntValidator {bottom: heightBottom; top: heightTop}
                        color: (acceptableInput) ? mainColor : "red"
                        onTextEdited:  {
                            if(currentEdit)
                            {
                                tfWidth.text = Math.round(text * sideRelation)
                            }
                            currentEdit != currentEdit
                        }
                    }

                    Text {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter

                        font.pointSize: fontSize
                        text: qsTr("Height range: [" + heightBottom + ";" + heightTop + "]")
                        color: "red"
                        visible: !tfHeight.acceptableInput
                    }
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
                width: parent.width

                Label {
                    text: qsTr("Max amount of colors:")
                    color: mainAppColor
                    font.pointSize: fontSize
                }

                Item {
                    width: parent.width
                    height: tfColors.height
                    TextField{
                        id: tfColors
                        text: "40"
                        font.pointSize: fontSize

                        validator: IntValidator {bottom: maxColorsBottom; top: maxColorsTop}
                        color: (acceptableInput) ? mainColor : "red"
                    }
                    Text {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter

                        font.pointSize: fontSize
                        text: qsTr("Max colors range: [" + maxColorsBottom + ";" + maxColorsTop + "]")
                        color: "red"
                        visible: !tfColors.acceptableInput
                    }
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
                    font.pointSize:  fontSize
                }
                RadioButton {
                    id: rbAnchor
                    text: "Anchor"
                    font.pointSize:  fontSize
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
            anchors.margins: 10

            width: parent.width * 0.4
            height: 50

            enabled: (tfWidth.acceptableInput
                      && tfHeight.acceptableInput
                      && tfColors.acceptableInput)
            text: "Create"
        }
    }
    MouseArea {
//        z: -10     //FIXME
        anchors.top: parent.top
        anchors.right: parent.right
        width: parent.width / 2
        height: parent.height / 2
        onClicked:
        {
            Qt.inputMethod.hide()
        }
    }
}
