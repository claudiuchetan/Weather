import QtQuick 1.0

Rectangle {
    property string icon:""
    property int customWidth: 47
    property int customHeight: 65
    property MouseArea mouseArea:click
    width: customWidth
    height: customHeight
    smooth: true
    color:"#00000000"
    Image {
        id: image
        fillMode: Image.TileHorizontally
        height: parent.height
        width:parent.width
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
        width: parent.width+20
        height: parent.height+20
        x:-10
        y:-10
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
