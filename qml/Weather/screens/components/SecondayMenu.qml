import QtQuick 1.0

    Rectangle {
        id:secondaryMenu
        width:parent.width
        height:50
        opacity: 0.5
        color:"#00000000"
        anchors.margins: {
            top: 9
            bottom: 9
            left: 9
            right: 9
        }
        Button {
            id:buttonSettings
            icon:"settings"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            customHeight: 24
            customWidth: 24
            onClicked: {
                switchView("Settings");
            }
        }
        Button {
            id:buttonRefresh
            icon:"refresh"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            customHeight: 24
            customWidth: 24
            onClicked: {
                refresh();
            }
        }
        Button {
            id:buttonLogout
            icon:"logout"
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            customHeight: 24
            customWidth: 24
            onClicked: {
                Qt.quit();
            }
        }
    }
