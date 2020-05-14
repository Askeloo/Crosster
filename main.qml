import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    id: rootWindow
    visible: true
    width: 800
    height: 600
    minimumWidth: 700
    minimumHeight: 400
    title: qsTr("Hello World1")

    Image {
        id: loading_logo
        source: "qrc:/letter_S_red-256.png"
        anchors.centerIn: parent
    }


    property color backGroundColor : "#263238"
    property color topLoginPageColor: "#FFA726"
    property color mainAppColor: "#455A64"
    property color mainTextCOlor: "#64FFDA"
    property color friendListColor: "#37474F"
    property color friendMouseAreaColor: "#78909C"
    property color choosenFriendColor: "#00BFA5"
    property color onlineFriendColor: "#AED581"
    property color offlineFriendColor: "#FFAB91"
    property color borderColor: "#FFB74D"



    FontLoader {
        id: fontAwesome
        name: "fontawesome"
        source: "qrc:/fontawesome-webfont.ttf"
    }

    // Main stackview
    StackView {
        id: stackView
        focus: true
        anchors.fill: parent
    }

    Component.onCompleted: stackView.push("MainPage.qml")
}

