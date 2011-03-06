import QtQuick 1.0
//import QtWebKit 1.0

import QtMobility.location 1.1

//Rectangle {
//    color:"#F69"
//    Text {
//        anchors.fill: parent
//        anchors.horizontalCenter: parent.horizontalCenter
//        text: window.myLatitude+"x"+window.myLongitude
//    }
//    Component.onCompleted:{
//        //console.log("-> Analytics loaded");
//        //46.738390
//        //23.494177
//        //46.568302, 23.782997
//        gps.getCoordinates();
//        console.log("Analytics LAT:"+window.myLatitude);
//        console.log("Analytics LON:"+window.myLongitude);
////        window.getReverseGeoInfo(window.myLatitude,window.myLongitude);

//    }
//}
Rectangle {
    id: page
    width: 350
    height: 350
    color: "#aaa"

    Text {
        id: title
        text: "Simple position test app"
        font {pixelSize: 18; bold: true}
    }
    PositionSource {
        id: positionSource
        active: true
        updateInterval: 1000
    }
    Column {
        id: data
        anchors {top: title.bottom; left: title.left}
        Text {text: "<==== PositionSource ====>"; font.pixelSize: 14}
        Text {text: "positioningMethod: "  + printableMethod(positionSource.positioningMethod); font.pixelSize: 14}
        Text {text: "nmeaSource: "         + positionSource.nmeaSource; font.pixelSize: 14}
        Text {text: "updateInterval: "     + positionSource.updateInterval; font.pixelSize: 14}
        Text {text: "active: "     + positionSource.active; font.pixelSize: 14}
        Text {text: "<==== Position ====>"; font.pixelSize: 14}
        Text {text: "latitude: "   + positionSource.position.coordinate.latitude; font.pixelSize: 14}
        Text {text: "longitude: "   + positionSource.position.coordinate.longitude; font.pixelSize: 14}
        Text {text: "altitude: "   + positionSource.position.coordinate.altitude; font.pixelSize: 14}
        Text {text: "speed: " + positionSource.position.speed; font.pixelSize: 14}
        Text {text: "timestamp: "  + positionSource.position.timestamp; font.pixelSize: 14}
        Text {text: "altitudeValid: "  + positionSource.position.altitudeValid; font.pixelSize: 14}
        Text {text: "longitudeValid: "  + positionSource.position.longitudeValid; font.pixelSize: 14}
        Text {text: "latitudeValid: "  + positionSource.position.latitudeValid; font.pixelSize: 14}
        Text {text: "speedValid: "     + positionSource.position.speedValid; font.pixelSize: 14}
    }
    function printableMethod(method) {
        if (method == PositionSource.SatellitePositioningMethod)
            return "Satellite";
        else if (method == PositionSource.NoPositioningMethod)
            return "Not available"
        else if (method == PositionSource.NonSatellitePositioningMethod)
            return "Non-satellite"
        else if (method == PositionSource.AllPositioningMethods)
            return "All/multiple"
        return "source error";
    }
}
