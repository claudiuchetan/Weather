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
    property bool isLandscape: (body.width>450)
    property ListModel locationsModel: lModel
    property ListModel locationsForecastModel: fModel
    property string currentLocation: ""
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
        weatherTimer.start();
    }

    function switchView(newView) {
        cView=newView;
        screenManager.state="switch"
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
        LocationData.addLocation(selectedCity,selectedCountry,window.gLongitude,window.gLatitude);
        lModel.reload();
    }

    function getGeoInfo(){
        var queryString=LocationData.createGeoQuery(selectedCity,selectedCountry);
        gModel.source="http://nominatim.openstreetmap.org/search?q="+queryString;
        console.log(gModel.source);
        gModel.reload();

    }

    function getReverseGeoInfo(lat,lon){
        var queryString=LocationData.createReverseGeoQuery(lat,lon);
        //rModel.source="http://nominatim.openstreetmap.org/search?q="+queryString;
        //rModel.source="http://nominatim.openstreetmap.org/reverse?format=xml&accept-language=en-gb&lat=45.7479910462652&lon=21.2259409031774&addressdetails=1";
        rModel.source="http://nominatim.openstreetmap.org/reverse?format=xml&accept-language=en-gb&lat=45.8304100846569&lon=24.9244750266311&addressdetails=1";
        rModel.source="http://nominatim.openstreetmap.org/reverse?format=xml&accept-language=en-gb&"+queryString;
        console.log(rModel.source);
        rModel.reload();
    }

    /*returns the current weather for a location ID
      the result has the following fields: temperature,precipitation, wind_speed,humidity,pressure,weather_desc
    */
    function getCurrentInfo(locID){
        console.log("Reading online weather for: "+locID);
        //get the weather data from server
        var queryString=WeatherData.createQueryString(locID,"current");
        weatherModel.source="http://www.worldweatheronline.com/feed/weather.ashx?q="+queryString;
        console.log(weatherModel.source);
        weatherModel.reload();
        //get the weather data from DB
        return WeatherData.getWeatherRow(window.modelData);
    }

    function getCurrentInfoCached(locID){
        console.log("Reading cached data for location "+locID);
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
            if (myLatitude!="" && myLongitude!="") {
                window.getReverseGeoInfo(window.myLatitude,window.myLongitude);
                LocationData.addLocation(myCity,myCountry,window.myLongitude,window.myLatitude);
                lModel.reload();
            }
        }
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

        /*
      Handler for device rotation
      */
        Behavior on rotation {
            PropertyAnimation {
                duration: 1000; easing.type: Easing.OutExpo //Easing.OutElastic
            }
        }


        /*
      Listener for device orientation changes
      */
        OrientationSensor {
            id: orientation
            active: true
            onReadingChanged: {
                if (reading.orientation == OrientationReading.TopUp) {
                    setOrientation(0);
                }
                else if (reading.orientation == OrientationReading.TopDown)
                {
                    setOrientation(180);
                }
                else if (reading.orientation == OrientationReading.LeftUp)
                {
                    setOrientation(-90);
                }
                else if (reading.orientation == OrientationReading.RightUp)
                {
                    setOrientation(90);
                }
            }
        }

        PopupDialog {
            id:popupDialog
        }

        Component.onCompleted: {
            //Init.initDB();
            //Init.clean();
            gpsTimer.start();
            if (myLatitude!="" && myLongitude!="") {
                window.getReverseGeoInfo(window.myLatitude,window.myLongitude);
            } else {
                gpsTimer.start();
            }
            /*LocationData.setCurrentLocation(1);
            var curData=LocationData.getCurrentLocation();*/
            switchView("Home");
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
    }
}
