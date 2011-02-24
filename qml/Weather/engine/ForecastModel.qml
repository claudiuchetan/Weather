import QtQuick 1.0
import "LocationData.js" as locData

    XmlListModel {
        id:forecastModel
        property string locationID
        property string queryString:locData.createQueryString(locationID,"forecast");
        source:"http://www.worldweatheronline.com/feed/weather.ashx?q="+queryString
        query: "/data/weather"

        XmlRole { name: "tempMax"; query: "tempMaxC/number()" }
        XmlRole { name: "tempMin"; query: "tempMinC/number()" }
        XmlRole { name: "windspeed"; query: "windspeedKmph/number()" }
        XmlRole { name: "winddirection"; query: "winddirection/string()" }
        XmlRole { name: "weatherDesc"; query: "weatherDesc/string()" }
        XmlRole { name: "precipitation"; query: "precipMM/number()" }

                onStatusChanged: {
            if (status == XmlListModel.Ready) {
                console.log("ok "+forecastModel.get(0).temperature);
            }
        }
    }
