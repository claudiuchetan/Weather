import QtQuick 1.0
import "LocationData.js" as locData

    XmlListModel {
        id:currentModel
        property string locationID
        property string queryString:locData.createQueryString(locationID,"current");
        source:"http://www.worldweatheronline.com/feed/weather.ashx?q="+queryString
        query: "/data/current_condition"

        XmlRole { name: "temperature"; query: "temp_C/number()" }
        XmlRole { name: "weather"; query: "weatherDesc/string()" }
        XmlRole { name: "windspeed"; query: "windspeedKmph/number()" }
        XmlRole { name: "precipitation"; query: "precipMM/number()" }
        XmlRole { name: "humidity"; query: "humidity/number()" }
        XmlRole { name: "visibility"; query: "visibility/number()" }
        XmlRole { name: "pressure"; query: "pressure/number()" }
        XmlRole { name: "cloudcover"; query: "cloudcover/number()" }

        onStatusChanged: {
            if (status == XmlListModel.Ready) {
                console.log("ok "+currentModel.get(0).temperature);
            }
        }
    }

