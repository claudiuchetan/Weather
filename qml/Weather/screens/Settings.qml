import QtQuick 1.0

Rectangle {
    property int cHeight: parent.height
    property int cWidth: parent.width
    property string title: "Settings"

    width:cWidth
    height: cHeight
    color:"#00000000"
    Text {
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        text: title
    }
    Component.onCompleted:{
        console.log("-> "+title+" loaded");
    }
}
