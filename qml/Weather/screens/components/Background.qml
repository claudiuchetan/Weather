import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    /*
      This is the bottom most background, that moves with left-right sliding
      !maybe remove this
      */
    //    Image {
    //        id:slidingBackground
    //        source: "images/photo_05.jpg"
    //        width:parent.width*HomeBehaviour.locations.count()
    //        height:body.height
    //        fillMode: Image.Tile
    //        x: widgetWrapper.x/3-50;
    //        z:1
    //        Behavior on x { PropertyAnimation { duration: 200;  } }
    //    }

    /*
      The permanent background of the app; for DAY time
      */
//    Image {
//        id:background
//        source: cBackgroundDay
//        width: body.width
//        height: body.height
//        fillMode: Image.Tile
//    }

    /*
      The permanent background of the app; for Night time
      */
//    Image {
//        id:backgroundNight
//        source: cBackgroundNight
//        anchors.fill: parent
//        fillMode: Image.Tile
//        opacity: 0
//        states: [
//            State {
//                name: "day"
//                PropertyChanges { target: backgroundNight; opacity:0 }
//            },
//            State {
//                name: "night"
//                PropertyChanges { target: backgroundNight; opacity:1 }
//            }
//        ]
//        transitions: [
//            Transition {
//                NumberAnimation {
//                    target: backgroundNight; easing.type: Easing.OutCirc; properties: "opacity"; duration:300;
//                }
//            }
//        ]
//    }

}
