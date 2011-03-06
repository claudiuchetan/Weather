import QtQuick 1.0

Flow {
    property string locationName: "nowhere"
    property string weatherState: "undefined"
    property string temperature: "-13"
    property string iconSrc: "clear"
    property int iconWidth: 100
    property int iconHeight: 100
    property bool nightMode: false;
    property string nightSrc: (nightMode)?"_night":"";
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
            source: (iconSrc=="")?"":("../../images/"+iconSrc+""+nightSrc+".png")
        }
        Loader {
            width:100
            height:100
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source:(weatherState=="")?"LoadingIndicator.qml":""
        }
    }
    Rectangle {
        id:infoWrapper
        width:360
        height:250
        color: "#00000000"
        Text {
            id:location
            text: locationName
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: -30
            font.family: widgetFont.name
            font.pixelSize: 30
            style: Text.Raised
            styleColor: "#eee"
            color:"#3a3a3a"
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
            style: Text.Raised
            styleColor: "#eee"
        }
        Text {
            id:state
            text: weatherState
            smooth: true
            anchors.horizontalCenter: temp.horizontalCenter
            anchors.top:temp.bottom
            font.family: widgetFont.name
            font.pixelSize: 20
            anchors.topMargin: -40
            color:"#888"
            style: Text.Raised
            styleColor: "#eee"
        }
    }
}
