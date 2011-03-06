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
            //            window.popup.msg="Gmodel ready";
            //            window.popup.state="on";
            var itemsNo=geoModel.count;
            if (itemsNo>0){
                var gData=geoModel.get(0);
                window.gLongitude=gData.longitude;
                window.gLatitude=gData.latitude;
                window.geoReady=true;
                window.addLocation();
            }
        } else {
            if (status == XmlListModel.Error) {
                window.popup.msg="Geo model status error: "+geoModel.errorString();
                window.popup.state="permanent";
            }
        }
    }
}
//http://nominatim.openstreetmap.org/search?q=vienna,+austria&format=xml&addressdetails=1
