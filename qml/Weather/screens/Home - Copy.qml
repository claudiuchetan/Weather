import QtQuick 1.0
import QtMobility.sensors  1.1
import "components"



Rectangle {
    id:widgetWrapper
    width:body.width*HomeBehaviour.locations.count()
    height:517
    color:"#00000000"
    z:10

    Row {
        width:parent.width
        y:50
        height:parent.height-50
        Repeater {
            model:{ return HomeBehaviour.locations.count() }
            WeatherWidget {
                locationName: HomeBehaviour.locations.get(index).name
                temperature: HomeBehaviour.weather.get(index).degrees+"\u00B0C"
                weatherState: HomeBehaviour.weather.get(index).name
//                icon: HomeBehaviour.weather.get(index).icon
//                night: HomeBehaviour.weather.get(index).night
                iconSrc: HomeBehaviour.weather.get(index).icon.src
                iconWidth: HomeBehaviour.weather.get(index).icon.width
                iconHeight: HomeBehaviour.weather.get(index).icon.height
                z:10
            }
        }
    }
    Behavior on x {
        PropertyAnimation {
            duration: 200; easing.type: Easing.OutCurve
        }
    }

    Rectangle {
        id:arrows
        height:20
        y:253
        x:0
        width:body.width
        color:"#00000000"
        opacity: 0
        Image {
            source: "../images/arrow_left.png"
            width:18
            x:20
        }
        Image {
            source: "../images/arrow_left.png"
            width:18
            rotation: 180
            x:parent.width-38
        }
        z:12
    }

    Hr {
        anchors.top: arrows.bottom
        anchors.topMargin: 10
        z:12
    }



    MouseArea {
        id:widgetClick
        width: body.width
        height:widgetWrapper.height
        anchors.top: widgetWrapper.top
        drag.target:widgetWrapper
        drag.axis:Drag.XAxis
        drag.minimumX:- (body.width*(HomeBehaviour.locations.count()-1)+90)
        drag.maximumX:90
        hoverEnabled:true
        onPositionChanged: {
            if (widgetClick.pressed) {
                background.x = widgetWrapper.x/3-50;
            }
        }
        onPressed: {
            body.state="mousePressed";
        }
        onReleased: {
            body.state="mouseReleased";
            widgetWrapper.x = HomeBehaviour.scrollToLocation(widgetWrapper.x, body.width)
            background.x = HomeBehaviour.startingBlock*body.width/3-50;

            if (HomeBehaviour.weather.get(Math.abs(HomeBehaviour.startingBlock)).icon.night == true) {
                backgroundNight.state="night"; }
                else {
                backgroundNight.state="day";
            }
        }
        z:11
    }

    states: [
        State {
            name: "mousePressed"
            PropertyChanges { target: arrows; opacity:1 }
        },
        State {
            name: "mouseReleased"
            PropertyChanges { target: arrows; opacity:0 }
        },
        State {
            name: "screenSettings"
            PropertyChanges { target: screenManager; source:"screens/Settings.qml" }
        },
        State {
            name: "screenHome"
            PropertyChanges { target: screenManager; source:"screens/Home.qml" }
        }

    ]
    transitions: [
        Transition {
            from:  "mousePressed"; to:"mouseReleased";
            NumberAnimation {
                target: arrows; easing.type: Easing.InQuint; properties: "opacity"; duration:1000;
            }
        },

        Transition {
            from:  "mouseReleased"; to:"mousePressed";
            NumberAnimation {
                target: arrows; easing.type: Easing.OutQuint; properties: "opacity"; duration:100;
            }
        }
    ]
}
