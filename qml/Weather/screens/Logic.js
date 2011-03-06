Qt.include("../engine/weatherIcons.js");
var currentWeatherQueue=[];
var forecastWeatherQueue=[];
var forecastDays=[];

function getIcon(code) {
    for (var i=0;i<weatherIcons.length;i++) {
        var icon=weatherIcons[i];
        for (var j=0;j<icon.codes.length;j++) {
            if (icon.codes[j]==code) {
                return icon;
            }
        }
    }
    console.log("Returning default icon.");
    return weatherIcons[0];
}

function checkIfNight(imageUrl) {
    var find=imageUrl.indexOf("night");
    if (find<0) {
        find=imageUrl.indexOf("black");
    }
    if (find>0) {
        return true;
    }
    return false;
}

function reloadCurrentWeatherModel(model) {
    model.clear();
    var locations=LocationData.listLocations();
    for (var i=0;i<locations.length;i++) {
        var degrees="",description="",icon="",night="";
        var weatherData=getCurrentInfoCached(locations[i].id);
        if (weatherData=="") {
            currentWeatherQueue.push(locations[i].id);
        } else {
            degrees=weatherData.temperature;
            description=weatherData.weather_desc;
            night=checkIfNight(weatherData.image_url);
            icon=Logic.getIcon(weatherData.code);
        }
        model.append({
                     "degrees": degrees,
                     "description": description,
                     "city": locations[i].name,
                     "country": locations[i].country,
                     "night": night,
                     "id": locations[i].id,
                     "last":(i==locations.length-1)?true:false,
                     "icon":icon});
        if (locations[i].current=="true") {
            window.currentLocation=locations[i].id;
        }
    }
    if (currentWeatherQueue.length>0) {
        getCurrentWeatherFromQueue(); }
}

function reloadForecastWeatherModel(model) {
    model.clear();
    var locations=LocationData.listLocations();
    var weatherData=null;
    for (var i=0;i<locations.length;i++) {
        var degrees="",description="",icon="";
        weatherData=getForecastInfoCached(locations[i].id);
        if (weatherData=="") {
            console.log("no data, loading from online");
            forecastWeatherQueue.push(locations[i].id);
        }
        model.append({
                     "name": locations[i].name,
                     "id": locations[i].id,
                     "weatherData":weatherData});

    }
    if (weatherData) {
        //if you got some data, look over the last array and extract the dates for forecast
        for (var i=0;i<weatherData.length;i++) {
            forecastDays.push(weatherData[i].date_forecast);
        }
    }
    if (forecastWeatherQueue.length>0) {
        getForecastWeatherFromQueue(); }
}

function formatDate(date) {
    return date.substring(5,date.length);
}
function getForecastDay(index) {
    if (forecastDays[index]) {
        return formatDate(forecastDays[index]);
    } else {
        return "";
    }
}
function showWeatherError(src,error) {

    src=src+" ";
    var indexStart=src.indexOf("?q=");
    if (indexStart>0) {
        window.popup.msg="Error retrieving weather information for \n"
        indexStart=indexStart+3;
        var indexEnd=src.indexOf("&format");
        window.popup.msg+='"'+src.substr(indexStart,indexEnd-indexStart)+'"\n';
        window.popup.msg+=error;
        window.popup.state="permanent"
    }
}
