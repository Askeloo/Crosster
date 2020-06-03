import QtQuick 2.0
import QtQuick.Controls 2.12

Page {
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        InfoTabPage1 {
            id: itp1

        }

        InfoTabPage2 {
            id: itp2

        }

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: "Info"
        }
        TabButton {
            text: "Flosses"
        }
    }
}


