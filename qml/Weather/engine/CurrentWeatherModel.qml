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
        XmlRole { name: "code"; query: "weatherCode/number()" }
        XmlRole { name: "image"; query: "weatherIconUrl/string()" }

        onStatusChanged: {
            if (status == XmlListModel.Ready) {
                if (currentModel.count>0){
                    var modelData=currentModel.get(0);
                    var temp=modelData.temperature;
                    var precip=modelData.precipitation;
                    var wind=modelData.windspeed;
                    var hum=modelData.humidity;
                    var pres=modelData.pressure;
                    if (modelData.weather!=""){
                        if (temp==""){temp=0;}
                        if (precip==""){precip=0;}
                        if (wind==""){wind=0;}
                        if (hum==""){hum=0;}
                        if (pres==""){pres=0;}

                    }
                    var wID=0;
                    wID=WData.saveCurrentWeather("current",gLocationID,temp,"","",precip,wind,hum,pres,modelData.weather,"",modelData.code,modelData.image);
                    window.modelReady=true;
                    //returns the id of the row which was saved in Weather_Data
                    window.modelData=wID;
                    window.locationsModel.reload();
                }
                window.getCurrentWeatherFromQueue();
            } else if (status == XmlListModel.Error) {
//                window.getLogic().showWeatherError(currentModel.source,currentModel.errorString());
            }
        }
    }

