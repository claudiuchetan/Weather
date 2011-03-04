import QtQuick 1.0
import "WeatherData.js" as WInfo

XmlListModel {
    id:forecastModel
    source:""
    query: "/data/weather"

    XmlRole { name: "date"; query: "date/string()" }
    XmlRole { name: "tempMax"; query: "tempMaxC/number()" }
    XmlRole { name: "tempMin"; query: "tempMinC/number()" }
    XmlRole { name: "windspeed"; query: "windspeedKmph/number()" }
    XmlRole { name: "winddirection"; query: "winddirection/string()" }
    XmlRole { name: "weatherDesc"; query: "weatherDesc/string()" }
    XmlRole { name: "precipitation"; query: "precipMM/number()" }
    XmlRole { name: "code"; query: "weatherCode/number()" }
    XmlRole { name: "image"; query: "weatherIconUrl/string()" }

    onStatusChanged: {
        if (status == XmlListModel.Ready) {
            var wIDs=[];
            var itemsNo=forecastModel.count;
            if (itemsNo>0){
                for (var i=0;i<itemsNo;i++) {
                    var forecastData=forecastModel.get(i);
                    var wID=0;
                    wID=WInfo.saveCurrentWeather("forecast",gLocationID,"",forecastData.tempMin,forecastData.tempMax,forecastData.precipitation,forecastData.windspeed,"","",forecastData.weatherDesc,forecastData.date,forecastData.code,forecastData.image);
                    wIDs=wID;
                }
            window.modelReady=true;
            var temp = window.forecastData;
            temp=wIDs;
            //return all the ids in Weather_Data which were saved in DB
            window.forecastData=temp;
            }
            window.getForecastWeatherFromQueue();
        }
    }
}


