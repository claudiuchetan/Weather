import QtQuick 1.0
import "LocationData.js" as LData

XmlListModel {
    id:revGeoModel
    source: ""
    query: "/reversegeocode"

    XmlRole { name: "location"; query: "result/string()" }
    XmlRole { name: "city"; query: "addressparts/city/string()" }
    XmlRole { name: "town"; query: "addressparts/town/string()" }
    XmlRole { name: "village"; query: "addressparts/village/string()" }
    XmlRole { name: "suburb"; query: "addressparts/suburb/string()" }
    XmlRole { name: "county"; query: "addressparts/county/string()" }
    XmlRole { name: "country"; query: "addressparts/country/string()" }

    onStatusChanged: {
        if (status == XmlListModel.Ready)  {
            var cityData="";
            if (revGeoModel.count>0){
                var gData=revGeoModel.get(0);
                if (gData.city != ""){
                    cityData=gData.city;
                }
                else{
                    if (gData.town != ""){
                        cityData=gData.town;
                    }
                    else{
                        if (gData.village!= ""){
                            cityData=gData.village;
                        }
                        else{
                            if (gData.suburb!=""){
                                cityData=gData.suburb;
                            }
                            else{
                                if (gData.county!=""){
                                    cityData=gData.county;
                                }
                            }
                        }
                    }
                }
                var country=gData.country;
                window.myCity=cityData;
                window.myCountry=country;
                window.alert("You are in \n"+cityData+"  "+country);
                window.addGpsLocation(cityData,country,window.myLongitude,window.myLatitude);
            }
        }
    }
}
