import QtQuick 1.0

Rectangle {
    width: parent.width
    height: 2
    color:"#999"
    Rectangle {
        width:  parent.width;
        height: 1
        color:"#FFF"
        anchors.bottom: parent.bottom
    }
    opacity:0.6
}
