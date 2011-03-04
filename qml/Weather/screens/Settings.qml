import QtQuick 1.0
import "../screens/components"
import "../engine"
import "../engine/LocationData.js" as LocationData

Rectangle {
    id:wrapper
    color:"#00000000"

    /*
     * Country input
     */
    Image {
        id:countryInput
        source:"../images/locationInput.png"
        y:50
        height:62
        width:parent.width-87
        anchors.horizontalCenter: parent.horizontalCenter
        z:103
    }
    Image {
        id:countryInputLeft
        source:"../images/locationInputLeft.png"
        anchors.verticalCenter: countryInput.verticalCenter
        height:countryInput.height
        width:23
        anchors.right: countryInput.left
        z:countryInput.z
    }
    Image {
        id:countryInputRight
        source:"../images/countryInputRight.png"
        anchors.verticalCenter: countryInput.verticalCenter
        height:countryInput.height
        width:23
        anchors.left: countryInput.right
        z:countryInput.z
    }
    Text {
        id:countryName
        width:countryInput.width-10
        font.pixelSize: 18
        font.capitalization: Font.AllUppercase
        color:(window.selectedCountry=="")?"#bbb":"#333"
        text:  "Select Country"
        clip:true
        anchors.verticalCenter: countryInput.verticalCenter
        anchors.left: countryInput.left
        z:countryInput.z+1
    }
    MouseArea {
        anchors.fill: countryInput
        onClicked: {
            selectCountry.state="on"
        }
        z:countryInput.z+1
    }


    /*
     * City input
     */
    Image {
        id:backInput
        source:"../images/locationInput.png"
        anchors.top: countryInput.bottom
        height:62
        width:parent.width-140
        anchors.left: countryInput.left
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
        text:  "Add City"
        clip:true
        anchors.verticalCenter: backInput.verticalCenter
        anchors.left: backInput.left
        z:backInput.z+1
        readOnly: (window.selectedCountry=="")?true:false
        color:(window.selectedCountry=="")?"#bbb":"#333"
    }

    Rectangle {
        id:locationList
        width:backInput.width+backInputRight.width-5
        y: backInput.y+40
        radius:8
        color:"#333"
        height: Math.min(wrapper.height-220,39*(list.count+1))
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
        onClicked : {
            if (window.selectedCountry!="") {
                if (input.text!="") {
                    window.selectedCity=input.text.toLowerCase();
                    window.getGeoInfo();
                    input.text=""
                } else {
                    window.popup.msg="Please enter a location name";
                    window.popup.state="on";
                }
            } else {
                window.popup.msg="You must choose a country";
                window.popup.state="on";
            }
        }
        z:backInput.z+1
    }


    /*
     * Country selector
     */
    Rectangle {
        id:selectCountry
        anchors.fill: parent
        opacity: 0.9
        color:"#000"
        z:countryInput.z-1
        state:"off"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                parent.state="off"
            }
        }
        CountriesModel {
            id:countries
        }
        ListView {
            id:countriesList

            model: countries
            height:parent.height-180
            width:parent.width-80
            anchors.top: parent.top
            anchors.topMargin: 100
            clip:true
            anchors.horizontalCenter: parent.horizontalCenter
            delegate:
                Column {
                width:parent.width
                Rectangle {
                    id:countryItemWrapper
                    height:countryItem.height
                    width: parent.width
                    color:"#00000000"
                    Text {
                        id:countryItem
                        text: name
                        color:  {
                            if (type=="header" || text==countryName.text) {
                                return "#69F";
                            } else {
                                return "#FFF";
                            }
                        }
                        height:(type=="header")?80:40
                        font.pixelSize: (type=="header")?30:14
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                    }
                    MouseArea {
                        anchors.fill: countryItemWrapper
                        onPressed: {
                            if (type!="header") {
                                countryItemWrapper.color="#ddd"
                                countryItem.color="#333"
                            }
                        }
                        onReleased: {
                            if (type!="header") {
                                countryItemWrapper.color="#00000000"
                                countryItem.color="#69f"
                            }
                        }
                        onClicked: {
                            if (type!="header") {
                                countryName.text=countryItem.text
                                selectCountry.state="off"
                                window.selectedCountry=countryItem.text.toLowerCase()
                            }
                        }
                    }
                    Hr {
                    }
                }
            }
        }
        states: [
            State {
                name:"off"
                PropertyChanges {
                    target: selectCountry
                    visible:false
                    opacity:0
                }
            },
            State {
                name:"on"
                PropertyChanges {
                    target: selectCountry
                    visible:true
                    opacity:0.9
                }
            }
        ]
        transitions:  [
            Transition {
                PropertyAnimation {
                    duration:600
                }
            }
        ]
    }

    Component.onCompleted: {
    }
}
