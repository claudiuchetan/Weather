import QtQuick 1.0

Flow {
    property string locationName: "nowhere"
    property string weatherState: "clear"
    property string temperature: "-13"
    property string iconSrc: "clear.png"
    property int iconWidth: 100
    property int iconHeight: 100
//    property bool isLandscape: (body.width>450)

    //    color: "#00000000"
    clip: true
    FontLoader {
        id:widgetFont
        source: "../../fonts/Nokia_standard_multiscript.ttf"
    }
    Rectangle {
        id:iconWrapper
        width:360
        height:250
        color: "#00000000"
        Image {
            width:iconWidth
            height:iconHeight
            smooth: true
            fillMode: Image.Tile
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "../../images/"+iconSrc
        }
    }
    Rectangle {
        id:infoWrapper
        width:isLandscape?280:360
        height:250
        color: "#00000000"
        Text {
            id:locationShadow
            text: locationName
            anchors.top:location.top
            anchors.topMargin: 1
            anchors.left: location.left
            anchors.leftMargin: 2
            font.family: widgetFont.name
            font.pixelSize: location.font.pixelSize
            color:"#FFF"
        }
        Text {
            id:location
            text: locationName
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: isLandscape?parent.verticalCenter:parent.top
//            anchors.horizontalCenterOffset: isLandscape?40:0
            anchors.verticalCenterOffset: isLandscape?-40:-30
            font.family: widgetFont.name
            font.pixelSize: 30
//            y:isLandscape?70:-55
            color:"#3a3a3a"
        }
        Text {
            id:temperatureShadow
            text: temperature
            smooth: true
            anchors.top:temp.top
            anchors.topMargin: 1
            anchors.left: temp.left
            anchors.leftMargin: 2
            font.family: widgetFont.name
            font.pixelSize: temp.font.pixelSize
            color:"#FFF"
        }
        Text {
            id:temp
            text: temperature
            smooth: true
            anchors.horizontalCenter: location.horizontalCenter
            anchors.top:location.bottom
            font.family: widgetFont.name
            font.pixelSize: 80
            anchors.topMargin: -40
            color:"#3a3a3a"
        }
    }
}
