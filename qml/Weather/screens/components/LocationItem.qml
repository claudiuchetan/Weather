import QtQuick 1.0

Rectangle {
    property string value:"undefined"
    property variant positionBufferX: 0
    property variant positionBufferY: 0
    width:parent.width
    height:39
    color:"#00000000"
    Text {
        id:name
        text: value
        verticalAlignment: Text.AlignVCenter
        height:parent.height
        font.pixelSize: 18
        font.capitalization: Font.AllUppercase
        color:(window.currentLocation==name.text)?"#F69":"#EEE"
    }
    Image {
        id:markCurrent
        width:24
        height:24
        anchors.right: name.right
        anchors.verticalCenter: name.verticalCenter
        source:"../../images/star.png"
        state: (window.currentLocation==name.text)?"checked":"unchecked"
        anchors.rightMargin: -30
        states: [
            State {
                name:"checked"
                PropertyChanges {
                    target: markCurrent
                    opacity:1
                }
            },
            State {
                name:"unchecked"
                PropertyChanges {
                    target: markCurrent
                    opacity:0
                }
            }
        ]
        transitions: [
            Transition {
                NumberAnimation { target: markCurrent; property: "opacity"; duration: 200 }
            }
        ]
    }
    MouseArea {
        id:nameMouseArea
        height:parent.height
        width: parent.width-40
        onClicked: {
            window.currentLocation=name.text
        }
    }
    Button {
        id:buttonRemove
        icon:"remove"
        anchors.right: parent.right
        anchors.verticalCenter: name.verticalCenter
        anchors.rightMargin: 8
        customHeight: 16
        customWidth: 15
        onClicked : {
            window.removeLocation(value);
        }
    }
    Hr {
        anchors.top: name.bottom
    }
}
