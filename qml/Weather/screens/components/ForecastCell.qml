import QtQuick 1.0

Rectangle {
    id: cell
    height:80
    width:60
    color:"#00000000"
    property string pValue: "-20"
    property string pName: "max"
    property string pUnit: "\u00B0C"
    property bool pBullet: true

    Column {
        width:parent.width-15
        height:parent.height
        Text {
            text:  pName
            horizontalAlignment: Text.AlignRight
            width:parent.width
            font.pixelSize: 14
            color:"#6e6e6e"
        }
        Text {
            text:  (pValue=="")?"?":pValue
            horizontalAlignment: Text.AlignRight
            width:parent.width
            font.pixelSize: 28
            color:(pValue=="")?"#999":"#111"
        }
        Text {
            text:  pUnit
            horizontalAlignment: Text.AlignRight
            width:parent.width
            font.pixelSize: 14
            color:"#6e6e6e"
        }
    }
    Text {
        text:  "\u25CF"
        opacity:0.5
        color:"#FFF"
        visible:pBullet
        anchors.left:cell.right
        anchors.leftMargin: -10
        font.pixelSize: 14
        anchors.verticalCenter: parent.verticalCenter
    }
}
