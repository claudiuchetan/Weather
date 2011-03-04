import QtQuick 1.0

Rectangle {
    color:"#F69"
    Text {
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Analytics"
    }
    Component.onCompleted:{
        //console.log("-> Analytics loaded");
        gps.getCoordinates();
        console.log("Analytics LAT:"+window.myLatitude);
        console.log("Analytics LON:"+window.myLongitude);
        window.getReverseGeoInfo(window.myLatitude,window.myLongitude);

    }
}
