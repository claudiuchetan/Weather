import QtQuick 1.0

Rectangle {
    property string locationName: "nowhere"
    property variant forecast: "undefined"
    color:"#00000000"
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
    Rectangle {
        id:frame
        color:"#00000000"
        width:320
        height:200
        anchors.horizontalCenter: parent.horizontalCenter
        y:80
        Hr {
            id:zero
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -15
        }
        Rectangle {
            id:zeroCircle
            width:31
            height:31
            radius:16
            color:"#666"
            opacity:0.9
            smooth:true
            anchors.verticalCenter: zero.verticalCenter
            anchors.left: zero.left
            anchors.leftMargin: -15
        }
        Text {
            text: "0\u00B0C"
            color:"#FFF"
            anchors.horizontalCenter: zeroCircle.horizontalCenter
            anchors.verticalCenter: zeroCircle.verticalCenter
            font.pixelSize: 14
            style: Text.Raised
            styleColor: "#333"
            font.bold: true

        }
        Repeater {
            id:hotVariation
            model:forecast
            Rectangle {
                width:65
                height:40
                y:parent.height-temp_max*6-5
                x:{return 65*index }
                color:"#00000000"
                Rectangle {
                    width:31
                    height:31
                    radius:16
                    color:"#ff1f2f"
                    opacity:0.9
                    smooth:true
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    text: temp_max
                    color:"#FFF"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 14
                    style: Text.Raised
                    styleColor: "#333"
                    font.bold: true

                }
            }
        }
        Repeater {
            id:coldVariation
            model:forecast
            Rectangle {
                width:65
                height:40
                y:parent.height-temp_min*6-5
                x:{return 65*index }
                color:"#00000000"
                Rectangle {
                    width:31
                    height:31
                    radius:16
                    color:"#3a84ff"
                    smooth: true
                    opacity:0.9
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    text: temp_min
                    color:"#FFF"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 14
                    style: Text.Raised
                    styleColor: "#333"
                    font.bold: true

                }
            }
        }
    }
}
