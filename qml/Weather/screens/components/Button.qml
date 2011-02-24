import QtQuick 1.0

Rectangle {
    property string icon:""
    property int customWidth: 47
    property int customHeight: 65
    property MouseArea mouseArea:click
    width: customWidth
    height: customHeight
    clip: true
    smooth: true
    color:"#00000000"
    Image {
        id: image
        x: 2
        y: 0
        fillMode: Image.TileHorizontally
        height: parent.height
        source:"../../images/"+icon+".png"
        smooth: true
        Behavior on scale {
            PropertyAnimation {
                duration: 200
                easing.type: Easing.OutQuint
            }
        }
    }
    MouseArea {
        id: click
        anchors.fill: parent
        onPressed: {
            image.scale=0.8
        }
        onReleased: {
            image.scale=1.0
        }
        onClicked: {
            console.log("click");
        }
    }
}
