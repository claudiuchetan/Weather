import QtQuick 1.0

Rectangle {
    property string locationName: "nowhere"
    color:"#00000000"
    clip: true
    FontLoader {
        id:widgetFont
        source: "../../fonts/Nokia_standard_multiscript.ttf"
    }
    Text {
        id:location
        text: locationName
        anchors.top:parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: widgetFont.name
        font.pixelSize: 36
        style: Text.Raised
        styleColor: "#EEE"
        color:"#333"
        height:50
        clip:true
    }
    Hr {
        id:hr
        anchors.top: location.bottom
    }
    Column {
        anchors.top: hr.bottom
        Repeater {
            model:5
            ForecastItem {}
        }
    }
}
