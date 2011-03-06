import QtQuick 1.0

Rectangle {
    id: rectangle1
    property string pDay: "Wednesday"

    height:93
    width:360
    color:"#00000000"
    border.width: 0

    Text {
        id:day
        x: 0
        text: pDay
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignLeft
        rotation:-90
        font.pixelSize: 14
        font.capitalization: Font.AllUppercase
        color:"#333"
    }
    Hr {
        anchors.top: parent.bottom
        opacity:0.5
    }
}
