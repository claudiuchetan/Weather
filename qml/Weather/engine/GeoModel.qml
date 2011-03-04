import QtQuick 1.0
import "LocationData.js" as LData

    XmlListModel {
        id:geoModel
        source: ""
        query: "/searchresults/place"

        XmlRole { name: "latitude"; query: "@lat/number()" }
        XmlRole { name: "longitude"; query: "@lon/number()" }

        onStatusChanged: {
            if (status == XmlListModel.Ready) {
                var itemsNo=geoModel.count;
                if (itemsNo>0){
                    var gData=geoModel.get(0);
                    window.gLongitude=gData.longitude;
                    window.gLatitude=gData.latitude;
                    window.geoReady=true;
                    window.addLocation();
                }
            }
        }
    }
