import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Universal 2.12

ApplicationWindow {
    id: window
    visible: true
    title: "Crosster"

    property color mainAppColor: "grey"
    property color borderColor: "#263238"
    property color backGroundColor:  "lightgrey"

    property color topLoginPageColor: "#FFB74D"
    property color mainTextCOlor: "#64FFDA"
    property color friendListColor: "#37474F"
    property color friendMouseAreaColor: "#78909C"
    property color choosenFriendColor: "#00BFA5"
    property color onlineFriendColor: "#AED581"
    property color offlineFriendColor: "#FFAB91"


    property string prevTitle: "Open pattern"
    property string currentTitle: "Open pattern"

    property alias stackView: stackView
    property bool appIsBusy: false

    header: ToolBar {
        Material.foreground: "white"

        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
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
                text: window.currentTitle
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
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
                        text: "About"
                        onTriggered: aboutDialog.open()
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
            color: borderColor
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
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    drawer.close();
                    if(window.currentTitle !== model.title)
                    {
                        appIsBusy = true;
                        listView.currentIndex = index;
                        window.prevTitle = window.currentTitle;
                        if(pushOpen)
                            stackView.push(model.source);
                        else
                            stackView.replace(model.source);
                        window.currentTitle = model.title;
                    }
                }
            }

            model: ListModel {
                ListElement { title: "\uf5ae    Scheme"; pushOpen: false; source: "qrc:/PatternPage.qml" }
                ListElement { title: "\uf65e    Create new"; pushOpen: false; source: "qrc:/CreatePage.qml" }
                ListElement { title: "\uf07c    Open pattern"; pushOpen: false; source: "qrc:/OpenPage.qml" }
                ListElement { title: "\uf05a    About"; pushOpen: true; source: "qrc:/AboutPage.qml" }
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: "qrc:/OpenPage.qml"
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
                text: "Kek"
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }
    }


    FontLoader {
        id: fontAwesome
        name: "fontawesome"
        source: "qrc:/Font Awesome 5 Free-Solid-900.otf"
    }
}

