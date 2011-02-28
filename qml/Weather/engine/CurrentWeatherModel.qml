import QtQuick 1.0
import "WeatherData.js" as WData

    XmlListModel {
        id:currentModel
        source: "" 
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
            	console.log("statusChanged:"+XmlListModel.Ready);
                if (currentModel.count>0){
                    var modelData=currentModel.get(0);
                    var wID=0;
                    wID=WData.saveCurrentWeather("current",gLocationID,modelData.temperature,"","",modelData.precipitation,modelData.windspeed,modelData.humidity,modelData.pressure,modelData.weather,"");
                    window.modelReady=true;
                    //returns the id of the row which was saved in Weather_Data
                    console.log("ID-ul ESTE:"+wID);
                    window.modelData=wID;
                }
            }
        }
    }

