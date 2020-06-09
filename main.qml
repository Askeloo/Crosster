import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Universal 2.12

ApplicationWindow {
    id: window
    visible: true
    title: "Crosster"
//    title: "CS Helper"

//    Material.theme: Material.Teal
    Material.primary: Material.Teal
    Material.accent: Material.Teal
    Material.foreground: Material.Teal
//    Material.background: Material.LightGreen

    property color mainColor: Material.color(Material.Teal)
    property color mainAppColor: "grey"
    property color borderColor: "#263238"
    property color backGroundColor:  "lightgrey"

    property string prevTitle: "Scheme"  //hardcode
    property string currentTitle: "Scheme"  //hardcode

    property alias stackView: stackView
    property bool appIsBusy: false

    header: ToolBar {
        Material.foreground: "white"

        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                id: tbBurger
                //icon.name: stackView.depth > 1 ? "back" : "drawer"
                Text {
                    //anchors.fill: parent
                    z: 1
                    anchors.centerIn: parent
                    text: stackView.depth > 1 ? "\uf060" : "\uf0c9"
                    font.pointSize: 25
                    color: backGroundColor

                }
                onClicked: {
                    if (stackView.depth > 1) {
                        window.currentTitle = window.prevTitle
                        stackView.pop()
                        listView.currentIndex = -1
                    } else {
                        drawer.open()
                    }
                }
            }

            Label {
                id: titleLabel
//                anchors.left: tbBurger.right
                text: window.currentTitle
                color: backGroundColor
                font.pixelSize: 20
//                elide: Label.ElideRight
//                horizontalAlignment: Qt.AlignHCenter
//                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                visible: (window.currentTitle == "Scheme")  //hardcode
                Text {
                    z: 1
                    //anchors.fill: parent
                    anchors.centerIn: parent
                    text: "\uf142"
                    font.pointSize: 25
                    color: backGroundColor
                }
                onClicked: optionsMenu.open()

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: "About pattern"
                        onTriggered:
                        {
                            guiManager.updateProgress()
                            pushPage("qrc:/InfoPage.qml")
                            window.currentTitle = "About pattern";
                            //aboutDialog.open()
                        }
                    }
                }
            }
        }
    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        interactive: stackView.depth === 1


        Rectangle {
            id: info
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            //width: drawer.width + 1
            height: 0.33 * drawer.height

            //color: borderColor

            gradient: Gradient {
                GradientStop{
                    position: 0.0
                    color: "#009688" //(Material.Teal)
                }
                GradientStop{
                    position: 1.0
                    color: "#00695C"
                }
            }

            Column {
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.margins: 20
                spacing: 10
                Label {
                    text: "Cross"
                    font.italic: true
                    font.pointSize: 30
                    color: backGroundColor
                }
                Label {
                    text: "Stitch"
                    font.italic: true
                    font.pointSize: 30
                    color: backGroundColor
                }
                Label {
                    text: "Helper"
                    font.italic: true
                    font.pointSize: 30
                    color: backGroundColor
                }
            }
        }

        ListView {
            id: listView

            anchors.top: info.bottom
            focus: true
            currentIndex: -1
            width: drawer.width
            height: drawer.height

            boundsBehavior: Flickable.StopAtBounds

            delegate: ItemDelegate {
                width: drawer.width
                text: model.iconCode + model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    drawer.close();
                    if(window.currentTitle !== model.title)
                    {
                        appIsBusy = true;
                        listView.currentIndex = index;
                        //window.prevTitle = window.currentTitle;
                        if(pushOpen)
                            //stackView.push(model.source);
                            pushPage(model.source)
                        else
                            stackView.replace(model.source);
                        window.currentTitle = model.title;
                    }
                }
            }

            model: ListModel {
                ListElement { iconCode: "\uf5ae    "; title: "Scheme";
                    pushOpen: false; source: "qrc:/PatternPage.qml" }
                ListElement { iconCode: "\uf65e    "; title: "Create new";
                    pushOpen: false; source: "qrc:/CreatePage.qml" }
                ListElement { iconCode: "\uf07c    "; title: "Open pattern";
                    pushOpen: false; source: "qrc:/OpenPage.qml" }
                ListElement { iconCode: "\uf05a    "; title: "About";
                    pushOpen: true; source: "qrc:/AboutPage.qml" }
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: "qrc:/PatternPage.qml"
    }

    BusyIndicator {
        //FIXME
        id: busyIndicator
        z: 11
        anchors.centerIn: parent
        running: appIsBusy
    }

    Dialog {
        id: aboutDialog
        modal: true
        focus: true
        title: "About"
        x: (window.width - width) / 2
        y: window.height / 6
        width: Math.min(window.width, window.height) / 3 * 2
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                width: aboutDialog.availableWidth
                text: ";)"
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }

            Label {
                width: aboutDialog.availableWidth
                text: "kek"
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }
    }

    FontLoader {
        id: fontAwesome
        name: "fontawesome"
        source: "qrc:/files/Font Awesome 5 Free-Solid-900.otf"
    }


    function pushPage(page) {
        window.prevTitle = window.currentTitle;
        stackView.push(page)
    }
}

