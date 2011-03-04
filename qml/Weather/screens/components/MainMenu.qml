import QtQuick 1.0



/*
All screens menu; in portrait is at the bottom; in landscape is at the right
*/
Row {
    id:mainMenu
    height:65
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 15
    anchors.horizontalCenter: parent.horizontalCenter
    spacing:isLandscape?80:30
    Button {
        id:buttonHome
        icon:"home"
        customWidth: 53
        customHeight: 72
        anchors.top: parent.top
        anchors.topMargin: -7
        onClicked: {
            switchView("Home");
        }
    }
    Button {
        id:buttonForecast
        icon:"forecast"
        anchors.top: parent.top
        customWidth: 45
        onClicked: {
            switchView("Forecast");
        }
    }
    Button {
        id:buttonCharts
        icon:"graphics"
        customWidth: 42
        anchors.top: parent.top
        onClicked: {
            switchView("Analytics");
        }
    }
    Button {
        id:buttonMap
        icon:"map"
        anchors.top: parent.top
        onClicked: {
            switchView("Location");
        }
    }
    states: [
        State {
            name: "off"
            PropertyChanges { target: mainMenu; opacity:0; height: 100; visible:false}
        },
        State {
            name: "on"
            PropertyChanges { target: mainMenu; opacity:1; visible:true }
        }
    ]
    transitions: [
        Transition {
            NumberAnimation {
                target: mainMenu; easing.type: Easing.OutCirc; properties: "opacity, visible"; duration:600;
            }
            NumberAnimation {
                target: mainMenu; easing.type: Easing.OutCirc; properties: "height"; duration:300;
            }
        }
    ]
}
