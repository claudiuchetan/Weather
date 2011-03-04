import QtQuick 1.0

Rectangle {
    id: rectangle1
    property string pDay: "Wednesday"
    property string pWeather: "snow"
    property variant pIconWidth: 47
    property variant pIconHeight: 46
    property variant pTempMax: 25
    property variant pTempMin: 18
    property variant pWindSpeed: 13
    property variant pPrecipitationChance: 14
    property string pIconSrc:""


    height:93
    width:360
    color:"#00000000"
    border.width: 0

    Text {
        id:day
        x: -10
        text: pDay
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignLeft
        rotation:-90
        font.pixelSize: 14
        font.capitalization: Font.AllUppercase
        color:"#333"
    }
    Text {
        id:weather
        x: 20
        y: 0
        text: pWeather
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignTop
        horizontalAlignment: Text.AlignLeft
        rotation:-90
        font.pixelSize: 18
        font.capitalization: Font.AllUppercase
        color:"#777"
    }
    Rectangle {
        id:iconWrapper
        anchors.left: mask.left
        anchors.leftMargin: 25
        clip:true
        height:parent.height
        width:pIconWidth
        color:"#00000000"
        anchors.verticalCenter: parent.verticalCenter
        border.width:0
        Image {
            id:icon
            source: (pIconSrc=="")?"":("../../images/small_icons/"+pIconSrc)
            width:pIconWidth
            height:pIconHeight
            anchors.verticalCenter: parent.verticalCenter
            x:-20
            y:0
        }
    }
    Image {
        id:mask
        source:"../../images/mask.png"
        width:58
        height:93
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
            pUnit:"%"
            pBullet:false
        }
    }
    Hr {
        anchors.top: parent.bottom
        opacity:0.5
    }
}
