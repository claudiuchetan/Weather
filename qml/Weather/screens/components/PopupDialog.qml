import QtQuick 1.0

Rectangle {
    id:dialog
    property string msg:"No Message."
    width: parent.width-60
    height: 80
    opacity:0
    radius:10
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    z:1100
    Text {
        text: msg
        color:"#fb0a26"
        font.pixelSize: 14
        font.bold: false
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.fill: parent
        wrapMode: Text.WrapAnywhere

    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            dialog.state="off"
        }
    }
    states: [
        State {
            name:"off"
            PropertyChanges {
                target: dialog
                opacity:0
            }
        },
        State {
            name:"on"
            PropertyChanges {
                target: dialog
                opacity:0.9
            }
            StateChangeScript {
                script: {
                    timer.start()
                }
            }
        },
        State {
            name:"permanent"
            PropertyChanges {
                target: dialog
                opacity:0.9
            }
        }
    ]
    transitions:  [
        Transition {
            PropertyAnimation {
                duration:600
            }
        }
    ]
    Timer {
        id:timer
        interval:2000
        onTriggered: {
            dialog.state="off"
        }
    }
}
