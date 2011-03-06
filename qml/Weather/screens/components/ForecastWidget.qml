import QtQuick 1.0

Rectangle {
    property string locationName: "nowhere"
    property variant forecast: "undefined"
    color:"#00000000"
//    clip: true
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
        height:200
        Column {
            Repeater {
                model:forecast
                ForecastItem {
                    //date,temp_min,temp_max,precipitation,wind_speed,weather_desc
                    pTempMin: window.getLogic().normalize(temp_min)
                    pTempMax: window.getLogic().normalize(temp_max)
                    pPrecipitationChance: window.getLogic().normalize(precipitation)
                    pWindSpeed: window.getLogic().normalize(wind_speed)
                    pWeather: weather_desc
                    pIconSrc: window.getLogic().getIcon(code).src
                }
            }
        }
    }
}
