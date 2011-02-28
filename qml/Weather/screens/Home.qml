import QtQuick 1.0
import "../screens/homeBehaviour.js" as HomeBehaviour
import "../engine/LocationData.js" as LocationData
import"../engine/WeatherData.js" as WeatherData
import "../engine/init.js" as Init
import "components"

Item {
    y:30
    ListModel  {
        id: itemModel
        Component.onCompleted:{

            //ask for cached data in DB
            // db.listLocations();
            // for each:
            // db.getWeather(locationID);
//            for (var i=0;i<HomeBehaviour.locationsDev.length;i++) {
//                itemModel.append({
//                                 "degrees": HomeBehaviour.weatherDev[i].degrees,
//                                 "state": HomeBehaviour.weatherDev[i].name,
//                                 "name": HomeBehaviour.locationsDev[i].name,
//                                 "icon":HomeBehaviour.weatherDev[i].icon});
//            }
            var locations=LocationData.listLocations();
            for (var i=0;i<locations.length;i++) {
                var j=HomeBehaviour.weatherDev[i].length%locations.length;
                itemModel.append({
                                 "degrees": HomeBehaviour.weatherDev[i].degrees,
                                 "state": HomeBehaviour.weatherDev[i].state,
                                 "name": locations[i].name,
                                 "icon":HomeBehaviour.weatherDev[i].icon});
            }
        }
    }

    ListView {
        id: view
        anchors { fill: parent; bottomMargin: 30 }
        model:  itemModel;
        delegate:
            Row{
            WeatherWidget {
                width:body.width
                height:body.height
                locationName: name
                temperature: degrees+"\u00B0C"
                weatherState: state
                iconSrc: icon.src
                iconWidth: icon.width
                iconHeight: icon.height
                z:10
            }
        }
        preferredHighlightBegin: 0;
        preferredHighlightEnd: 0
        highlightRangeMode: ListView.StrictlyEnforceRange
        orientation: ListView.Horizontal
        snapMode: ListView.SnapToItem
        flickDeceleration: 2000
    }

    Hr {
        y:240
        z:12
        visible: !isLandscape
    }
}
