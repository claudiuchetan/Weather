import QtQuick 1.0
import "../screens/components"
import "../engine/LocationData.js" as LocationData

Rectangle {
    id:wrapper
    color:"#00000000"

    Image {
        id:backInput
        source:"../images/locationInput.png"
        y:50
        height:62
        width:parent.width-140
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -30
        z:100
    }
    Image {
        id:backInputLeft
        source:"../images/locationInputLeft.png"
        anchors.verticalCenter: backInput.verticalCenter
        height:backInput.height
        width:23
        anchors.right: backInput.left
        z:backInput.z
    }
    Image {
        id:backInputRight
        source:"../images/locationInputRight.png"
        anchors.verticalCenter: backInput.verticalCenter
        height:backInput.height
        width:76
        anchors.left: backInput.right
        z:backInput.z
    }
    TextInput {
        id:input
        width:backInput.width-10
        font.pixelSize: 18
        font.capitalization: Font.AllUppercase
        color:"#333"
        text:  "aoleu"
        clip:true
        anchors.verticalCenter: backInput.verticalCenter
        anchors.left: backInput.left
        z:backInput.z+1
    }

    Rectangle {
        id:locationList
        width:backInput.width+backInputRight.width-5
        y: backInput.y+40
        radius:8
        color:"#333"
        height: Math.min(wrapper.height-120,39*list.count)
        z:backInput.z-3
        anchors.left: backInput.left
        anchors.leftMargin: -10
        clip:true
        ListView {
            id:list
            z:backInput.z-1
            anchors.fill: parent;
            model: locationsModel
            anchors.topMargin: 25
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            delegate:
                Column {
                width:parent.width
                LocationItem {
                    value: name
                }
            }
        }
    }
    Button {
        id:buttonAdd
        icon:"add"
        anchors.left: backInputRight.left
        anchors.verticalCenter: backInput.verticalCenter
        anchors.leftMargin: 25
        customHeight: 21
        customWidth: 20
        Connections {
            target: buttonAdd.mouseArea
            onClicked : {
                //                switchView("Settings");

                window.addLocation(input.text,"Romania");
            }
        }
        z:backInput.z+1
    }


    Component.onCompleted: {
        console.log("Settings loaded");
    }
}
