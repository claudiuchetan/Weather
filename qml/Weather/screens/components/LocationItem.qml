import QtQuick 1.0

Rectangle {
    property string pCity:"undefined"
    property string pCountry:"undefined"
    property variant positionBufferX: 0
    property variant positionBufferY: 0
    property bool pLast:false
    property int pId:-1
    width:parent.width
    height:50
    color:"#00000000"
    Text {
        id:city
        text: pCity
        verticalAlignment: Text.AlignVCenter
        height:20
        font.pixelSize: 18
        font.capitalization: Font.AllUppercase
        color:(window.currentLocation==pId)?"#F69":"#EEE"
    }
    Text {
        id:country
        text: pCountry
        verticalAlignment: Text.AlignVCenter
        height:14
        font.pixelSize: 12
        font.capitalization: Font.AllUppercase
        color:(window.currentLocation==pId)?"#A47":"#999"
        anchors.top: city.bottom
    }
    Image {
        id:markCurrent
        width:24
        height:24
        anchors.right: city.right
        anchors.verticalCenter: city.verticalCenter
        source:"../../images/star.png"
        state: (window.currentLocation==pId)?"checked":"unchecked"
        anchors.rightMargin: -40
        states: [
            State {
                name:"checked"
                PropertyChanges {
                    target: markCurrent
                    opacity:1
                }
            },
            State {
                name:"unchecked"
                PropertyChanges {
                    target: markCurrent
                    opacity:0
                }
            }
        ]
        transitions: [
            Transition {
                NumberAnimation { target: markCurrent; property: "opacity"; duration: 200 }
            }
        ]
    }
    MouseArea {
        id:nameMouseArea
        height:parent.height
        width: parent.width-40
        onClicked: {
            window.markCurrent(pId);
        }
    }
    Button {
        id:buttonRemove
        icon:"remove"
        anchors.right: parent.right
        anchors.verticalCenter: city.verticalCenter
        anchors.rightMargin: 8
        customHeight: 16
        customWidth: 15
        onClicked : {
            window.removeLocation(pCity,pCountry);
        }
    }
    Hr {
        anchors.top: country.bottom
        anchors.topMargin: 3
        visible: (!pLast)
    }
}
