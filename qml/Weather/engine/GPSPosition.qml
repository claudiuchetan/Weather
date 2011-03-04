import QtQuick 1.0
import QtMobility.location 1.1


PositionSource {
             id: positionSource
             updateInterval: 1000
             active: true

             function getCoordinates(){
                window.myLatitude=positionSource.position.coordinate.latitude;
                window.myLongitude=positionSource.position.coordinate.longitude;
                console.log("LAT:"+window.myLatitude);
                console.log("LON:"+window.myLongitude);
             }
}
