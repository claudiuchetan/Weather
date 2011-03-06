import QtQuick 1.0

Rectangle {
    id: rectangle1
    property string pWeather: "snow"
    property variant pIconWidth: 64
    property variant pIconHeight: 64
    property string pTempMax: "25"
    property string pTempMin: "18"
    property string pWindSpeed: "13"
    property string pPrecipitationChance: "14"
    property string pIconSrc:""

    height:93
    width:body.width
    color:"#00000000"
    border.width: 0
    Text {
        id:weather
        x: 20
        y: 0
        text: pWeather
        verticalAlignment: Text.AlignTop
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 12
        color:"#333"
        anchors.horizontalCenter: icon.horizontalCenter
        anchors.top: icon.bottom
        anchors.topMargin: -5
    }
    Image {
        id:icon
        source: (pIconSrc=="")?"":("../../images/small_icons/"+pIconSrc+".png")
        width:pIconWidth
        height:pIconHeight
        anchors.verticalCenter: parent.verticalCenter
        x:40
    }
    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        ForecastCell {
            pValue:pTempMax
            pName:  "max"
            pUnit:"\u00B0C"
        }
        ForecastCell {
            pValue:pTempMin
            pName:  "min"
            pUnit:"\u00B0C"
        }
        ForecastCell {
            pValue:pWindSpeed
            pName:  "wind"
            pUnit:"km/h"
        }
        ForecastCell {
            pValue:pPrecipitationChance
            pName:  "rain"
            pUnit:"mm"
            pBullet:false
        }
    }
}
