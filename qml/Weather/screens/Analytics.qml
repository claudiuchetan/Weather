import QtQuick 1.0
import QtWebKit 1.0

Rectangle {
    color:"#F69"
    Text {
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        text: window.myLatitude+"x"+window.myLongitude
    }
    Component.onCompleted:{
        //console.log("-> Analytics loaded");
        //46.738390
        //23.494177
        //46.568302, 23.782997
        gps.getCoordinates();
        console.log("Analytics LAT:"+window.myLatitude);
        console.log("Analytics LON:"+window.myLongitude);
        window.getReverseGeoInfo(window.myLatitude,window.myLongitude);

    }
}
