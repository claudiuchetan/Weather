import QtQuick 1.0
import QtMobility.sensors  1.1
import "engine/utils.js" as Utils
import "engine/init.js" as Init
import "screens"
import "engine"
import"engine/WeatherData.js" as Test
import "screens/components"

Rectangle {
    id:window
    property string cView:""
    property string backDayPortrait:"images/background.png"
    property string backNightPortrait:"images/background_night.png"
    property string backDayLandscape:"images/background_landscape.png"
    property string backNightLandscape:"images/background_landscape_night.png"
    property string cBackgroundDay:backDayPortrait
    property string cBackgroundNight:backNightPortrait
    property bool isLandscape: (body.width>450)
    color:"#333"
	property int gLocationID:1
    property bool modelReady: false
    property int modelData: 0
    property variant forecastData:null

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

    /*returns the current weather for a location ID
      the result has the following fields: temperature,precipitation, wind_speed,humidity,pressure,weather_desc
    */

    function getCurrentInfo(locID){
        var savedCurrent="";
        var savedData=Test.verifyLastReq(locID,"current");
        //if weather data for locID has not been saved in DB in the last hour
        if (savedData == "")
        {
            //get the weather data from server
            var queryString=Test.createQueryString(locID,"current");
            test1.source="http://www.worldweatheronline.com/feed/weather.ashx?q="+queryString;
            console.log(test1.source);
            test1.reload();
            //get the weather data from DB
            savedCurrent=Test.getWeatherRow(window.modelData);
        }
        else{
            savedCurrent=savedData;
        }
    return savedCurrent;
    }

    /*returns the forecast for the interval today -> today+4days
      the answer includes 5 objects, each having the following fields:date,temp_min,temp_max,precipitation,wind_speed,weather_desc
    */
function getForecastInfo(locID){
        var savedForecast=[];
        var alreadyData=Test.verifyLastReq(locID,"forecast");
        if (alreadyData.length<1)
        {
            var queryString=Test.createQueryString(locID,"forecast");
            fModel.source="http://www.worldweatheronline.com/feed/weather.ashx?q="+queryString;
            console.log(fModel.source);
            fModel.reload();
            var weatherIDs=window.forecastData;
            //foreach id returned by the model, get the row from database
            for (var i=0;i<weatherIDs.length; i++){
                savedForecast=Test.getWeatherRow(weatherIDs[i]);
            }
        }
        else{
           savedForecast=alreadyData;
        }
        return savedForecast;
    }

    Rectangle {
        id:body
        color: "#00000000"
        width:parent.width
        height: parent.height

        //Add the background
//        Background {
//        }

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

        Rectangle {
            width:isLandscape?32:body.width
            height:isLandscape?body.height:32
            border.width: 1
            color:"#00000000"
            anchors.margins: {
                top: 9
                bottom: 9
                left: 9
                right: 9
            }
            Flow {
                flow: isLandscape?Flow.TopToBottom:Flow.LeftToRight
                Image {
                    source: "images/settings.png"
                }
                Image {
                    source: "images/refresh.png"
                }
                Image {
                    source: "images/logout.png"
                }
            }
        }
        /*
      the foreground that appears above screens but behind the main buttons
      */
        Image {
            id: foreground
            source:  "images/foreground.png"
            width:body.width
            height:195
            y:body.height-120
            z:900
        }

        /*
      All screens menu; in portrait is at the bottom; in landscape is at the right
      */
        Row {
            id:mainMenu
            height:65
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            z:1000
            spacing:isLandscape?80:30
            Button {
                id:buttonHome
                icon:"home"
                anchors.top: parent.top
                Connections {
                    target: buttonHome.mouseArea
                    onClicked : {
                        switchView("Home");
                    }
                }
            }
            Button {
                id:buttonForecast
                icon:"forecast"
                anchors.top: parent.top
                Connections {
                    target: buttonForecast.mouseArea
                    onClicked : {
                        switchView("Forecast");
                    }
                }
            }
            Button {
                id:buttonCharts
                icon:"graphics"
                anchors.top: parent.top
                Connections {
                    target: buttonCharts.mouseArea
                    onClicked : {
                        switchView("Analytics");
                    }
                }
            }
            Button {
                id:buttonMap
                icon:"map"
                anchors.top: parent.top
                Connections {
                    target: buttonMap.mouseArea
                    onClicked : {
                        switchView("Location");
                    }
                }
            }
            states: [
                State {
                    name: "off"
                    PropertyChanges { target: mainMenu; opacity:0; height: 100; visible:false}
                },
                State {
                    name: "on"
                    PropertyChanges { target: mainMenu; opacity:1; visible:true }
                }
            ]
            transitions: [
                Transition {
                    NumberAnimation {
                        target: mainMenu; easing.type: Easing.OutCirc; properties: "opacity, visible"; duration:600;
                    }
                    NumberAnimation {
                        target: mainMenu; easing.type: Easing.OutCirc; properties: "height"; duration:300;
                    }
                }
            ]
        }



        /*
      The secondary options menu; always appears as a bar at the bottom
      !need to add icon so that the slide action is more clear to the user
      */
        Drawer {
            id:drawer
            z:99
            Connections {
                target:  drawer.flick
                onContentYChanged: {
                    if (drawer.flick.contentY>10) {
                        mainMenu.state="off";
                    } else {
                        mainMenu.state="on";
                    }
                }
            }
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
        Component.onCompleted: {
            Init.initDB();
            switchView("Home");
        }
	CurrentWeatherModel{
            id:test1
        }
        ForecastModel{
            id:fModel
        }
    }
}
