import QtQuick 1.0
import QtMobility.sensors  1.1
import "engine/init.js" as Init
import "screens/Logic.js" as Logic
import "engine/LocationData.js" as LocationData
import "engine/Database.js" as Bla
import "screens"
import "engine"
import"engine/WeatherData.js" as WeatherData
import "screens/components"

Rectangle {
    id:window
    color:"#333"
    property string cView:""
    property string backDayPortrait:"images/background.png"
    property string backNightPortrait:"images/background_night.png"
    property string backDayLandscape:"images/background_landscape.png"
    property string backNightLandscape:"images/background_landscape_night.png"
    property string cBackgroundDay:backDayPortrait
    property string cBackgroundNight:backNightPortrait
    property ListModel locationsModel: lModel
    property ListModel locationsForecastModel: fModel
    property int currentLocation: 1
    property int gLocationID:0
    property string gLongitude:""
    property string gLatitude:""
    property string myLongitude:""
    property string myLatitude:""
    property string myCity:""
    property string myCountry:""
    property bool modelReady: false
    property bool geoReady:false
    property int modelData: 0
    property variant forecastData:null
    property Rectangle popup:popupDialog
    property string selectedCountry:""
    property string selectedCity:""

    function getLogic() {
        return Logic;
    }

    function refresh() {
        lModel.reload();
        fModel.reload();
    }

    function switchView(newView) {
        cView=newView;
        screenManager.state="switch"
    }

    function alert(msg) {
        popup.msg=msg;
        popup.state="permanent"
    }

    function setOrientation(angle) {
        body.rotation=angle;
        if (angle==0 || angle==180) {
            //portrait
            body.width=window.width
            body.height=window.height
            body.x=0
            body.y=0
            cBackgroundDay=backDayPortrait;
            cBackgroundNight=backNightPortrait;
        } else {
            //landscape
            body.width=window.height
            body.height=window.width
            body.x=-140
            body.y=140
            cBackgroundDay=backDayLandscape;
            cBackgroundNight=backNightLandscape;
        }
    }

    function cleanOnExit() {
        Init.cleanDB();
    }

    function removeLocation(name,country) {
        LocationData.deleteLocationbyName(name,country);
        lModel.reload();
    }

    function addLocation() {
//        LocationData.addLocation(selectedCity,selectedCountry,window.gLongitude,window.gLatitude);
        LocationData.addLocation(selectedCity,selectedCountry,"1","1");
        lModel.reload();
        fModel.reload();
    }

    function addGpsLocation(city, country, longitude, latitude) {
        LocationData.addLocation(city,country,longitude,latitude);
        weatherTimer.start();
    }

    /*returns the current weather for a location ID
      the result has the following fields: temperature,precipitation, wind_speed,humidity,pressure,weather_desc
    */
    function getCurrentInfo(locID){
        //get the weather data from server
        var queryString=WeatherData.createQueryString(locID,"current");
        weatherModel.source="http://www.worldweatheronline.com/feed/weather.ashx?q="+queryString;
        console.log(weatherModel.source);
        weatherModel.reload();
        //get the weather data from DB
        return WeatherData.getWeatherRow(window.modelData);
    }

    function getCurrentInfoCached(locID){
        return WeatherData.verifyLastReq(locID,"current");
    }

    function getCurrentWeatherFromQueue() {
        if (Logic.currentWeatherQueue.length>0) {
            var locationID=Logic.currentWeatherQueue.pop();
            gLocationID=locationID;
            var data=getCurrentInfo(locationID);
                     if (data!="") {
                           weatherTimer.start();
                        }
        }
    }

    /*returns the forecast for the interval today -> today+4days
      the answer includes 5 objects, each having the following fields:date,temp_min,temp_max,precipitation,wind_speed,weather_desc
    */
    function getForecastInfo(locID){
        var savedForecast=[];
        var queryString=WeatherData.createQueryString(locID,"forecast");
        forecastModel.source="http://www.worldweatheronline.com/feed/weather.ashx?q="+queryString;
        forecastModel.reload();
        var weatherIDs=window.forecastData;
        //foreach id returned by the model, get the row from database
        if (weatherIDs) {
            for (var i=0;i<weatherIDs.length; i++){
                savedForecast=WeatherData.getWeatherRow(weatherIDs[i]);
            }
        }
        return savedForecast;
    }

    function getForecastInfoCached(locID){
        return WeatherData.verifyLastReq(locID,"forecast");
    }

    function getForecastWeatherFromQueue() {
        if (Logic.forecastWeatherQueue.length>0) {
            var locationID=Logic.forecastWeatherQueue.pop();
            gLocationID=locationID;
            var data=getForecastInfo(locationID);
            if (data!="") {
                weatherTimer.start();
            }
        }
    }

    Timer {
        id:weatherTimer
        interval:2000
        onTriggered: {
            lModel.reload();
        }
    }

    Timer {
        id:gpsTimer
        interval: 10000
        onTriggered: {
            gps.getCoordinates();
            if (!isNaN(myLatitude) && !isNaN(myLongitude) && myLatitude!="" && myLongitude!="") {
                popup.msg="I found your location. \nAdding it to the list.";
                popup.state="on";
                window.getReverseGeoInfo(window.myLatitude,window.myLongitude);
            } else {
//                popup.msg="No location was found, I'll try again in 10 seconds.'";
//                popup.state="on";
                gpsTimer.start();
            }
        }
    }

    function getGeoInfo(){
        var queryString=LocationData.createGeoQuery(selectedCity,selectedCountry);
        gModel.source="http://nominatim.openstreetmap.org/search?q="+queryString;
        gModel.reload();
    }

    function getReverseGeoInfo(lat,lon){
        var queryString=LocationData.createReverseGeoQuery(lat,lon);
        rModel.source="http://nominatim.openstreetmap.org/reverse?format=xml&accept-language=en-gb&lat=45.8304100846569&lon=24.9244750266311&addressdetails=1";
        rModel.source="http://nominatim.openstreetmap.org/reverse?format=xml&accept-language=en-gb&"+queryString;
        rModel.reload();
    }

    function markCurrent(id) {
        currentLocation=id;
        LocationData.setCurrentLocation(id);
    }

    CurrentWeatherModel{
        id:weatherModel
    }
    ForecastModel{
        id:forecastModel
    }
    GeoModel{
        id:gModel
    }
    ReverseGeoModel{
        id:rModel
    }
    GPSPosition{
        id:gps
    }

    ListModel  {
        id: lModel
        function reload() {
            Logic.reloadCurrentWeatherModel(lModel);
        }
        Component.onCompleted:{
            reload();
        }
    }

    ListModel  {
        id: fModel
        function reload() {
            Logic.reloadForecastWeatherModel(fModel);
        }
    }

    Rectangle {
        id:body
        color: "#00000000"
        width:parent.width
        height: parent.height

        Image {
            id:background
            source: cBackgroundDay
            anchors.fill: parent
        }
        Image {
            id:backgroundNight
            source: cBackgroundNight
            anchors.fill: parent
            opacity: 0
            states: [
                State {
                    name: "day"
                    PropertyChanges { target: backgroundNight; opacity:0 }
                },
                State {
                    name: "night"
                    PropertyChanges { target: backgroundNight; opacity:1 }
                }
            ]
            transitions: [
                Transition {
                    NumberAnimation {
                        target: backgroundNight; easing.type: Easing.OutCirc; properties: "opacity"; duration:300;
                    }
                }
            ]
        }
        Loader {
            id:screenManager
            z:100
            width:parent.width
            height:parent.height-mainMenu.height
            y:parent.height

            states: [
                State {
                    name: "switch"
                    PropertyChanges { target: screenManager; y:body.height}
                    onCompleted:  {
                        screenManager.source="screens/"+cView+".qml";
                        screenManager.state="on"
                    }
                },
                State {
                    name: "on"
                    PropertyChanges { target: screenManager; y:0}
                }
            ]
            transitions: [
                Transition {
                    NumberAnimation {
                        properties:"y"
                        duration:400; easing.type:Easing.OutBack
                    }
                }
            ]
        }

        SecondayMenu {
            z:900
        }

        /*
        the foreground that appears above screens but behind the main buttons
        */
        Image {
            id: foreground
            source:  "images/foreground.png"
            width:parent.width
            height:195
            y:body.height-120
            z:900
        }

        MainMenu {
            z:1000
            id:mainMenu
        }

        PopupDialog {
            id:popupDialog
        }

        Component.onCompleted: {
//            gpsTimer.start();
            if (LocationData.listLocations().length>0) {
                switchView("Home");
            } else {
                popup.msg="Please add some locations."
                switchView("Settings");
            }
        }
    }
}
