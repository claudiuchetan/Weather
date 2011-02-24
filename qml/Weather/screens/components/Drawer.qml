import QtQuick 1.0

Rectangle {
    property Flickable flick: drawerFlickable
    id:drawer
    y:parent.height-120
    width: parent.width
    height:120
    color:"#00000000"
    Flickable {
        id:drawerFlickable
        anchors.fill: parent
        contentHeight: image.height+buttonArea.height
        boundsBehavior: Flickable.DragOverBounds
        Image {
            id:image
            width: drawer.width
            height: 9
            anchors.top: parent.top
            anchors.topMargin: 110
            source: "../../images/drawer.png"
            fillMode: Image.TileHorizontally
        }
        Rectangle {
            id:buttonArea
            color:"#00000000"
//            opacity:0.6
            height:165
            width:drawer.width
            anchors.top: image.bottom
            Row {
                width: parent.width
                height:40
                anchors.top: parent.top
                anchors.topMargin: 15
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:40
                Button {
                    id:buttonSettings
                    icon:"settings"
                    customHeight:32
                    customWidth:60
                    Connections {
                        target: buttonSettings.mouseArea
                        onClicked: {
                           parent.state="screenSettings"
                        }
                    }
                }
                Button {
                    id:buttonExit
                    icon:"exit"
                    customHeight:32
                    customWidth:60
                    Connections {
                        target: buttonExit.mouseArea
                        onClicked: {
                           window.cleanOnExit();
                           Qt.quit();
                        }
                    }
                }
            }
        }
        Rectangle {
            id:fillArea
            color:buttonArea.color
            opacity:buttonArea.opacity
            height:300
            width:drawer.width
            anchors.top: buttonArea.bottom
        }
        onMovementEnded: {
            if (drawerFlickable.contentY<30) {
                drawerFlickable.contentY=0
            } else {
                drawerFlickable.contentY=54
            }
        }
    }
}
