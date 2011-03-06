import QtQuick 1.0

Rectangle {
    property string pDay: "Wednesday"

    height:20
    width:65
    color:"#00000000"
    border.width: 0

    Text {
        id:day
        text: pDay
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 14
        font.capitalization: Font.AllUppercase
        color:"#333"
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
