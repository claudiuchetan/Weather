import QtQuick 1.0

Rectangle {
    property string locationName: "nowhere"
    property variant forecast: "undefined"
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
    ListView {
        y:60
        Column {
            Repeater {
                model:forecast
                ForecastItem {
                    //date,temp_min,temp_max,precipitation,wind_speed,weather_desc
                    pTempMin:temp_min
                    pTempMax: temp_max
                    pPrecipitationChance: precipitation
                    pWindSpeed: wind_speed
                    pWeather: weather_desc
                    pIconSrc: window.getLogic().getIcon(code).src
                }
            }
        }
    }
    Loader {
        width: 100
        height:100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source:(forecast=="undefined")?"LoadingIndicator.qml":""
    }
}
