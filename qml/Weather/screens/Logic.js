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

function reloadCurrentWeatherModel(model) {
    model.clear();
    var locations=LocationData.listLocations();
    for (var i=0;i<locations.length;i++) {
        var degrees="",description="",icon="";
        var weatherData=getCurrentInfoCached(locations[i].id);
        if (weatherData=="") {
            currentWeatherQueue.push(locations[i].id);
        } else {
            degrees=weatherData.temperature;
            description=weatherData.weather_desc;
            icon=Logic.getIcon(weatherData.code);
        }
        model.append({
                     "degrees": degrees,
                     "description": description,
                     "city": locations[i].name,
                     "country": locations[i].country,
                     "id": locations[i].id,
                     "last":(i==locations.length-1)?true:false,
                     "icon":icon});
        if (locations[i].current==true) {
            window.currentLocation=locations[i].id;
        }
    }
    if (currentWeatherQueue.length>0) {
        getCurrentWeatherFromQueue(); }
}

function reloadForecastWeatherModel(model) {
    model.clear();
    var locations=LocationData.listLocations();
    for (var i=0;i<locations.length;i++) {
        var degrees="",description="",icon="";
        var weatherData=getForecastInfoCached(locations[i].id);
        if (weatherData=="") {
            console.log("no data, loading from online");
            forecastWeatherQueue.push(locations[i].id);
        }
        model.append({
                     "name": locations[i].name,
                     "id": locations[i].id,
                     "weatherData":weatherData});

    }
    for (var i=0;i<weatherData.length;i++) {
        forecastDays.push(weatherData[i].date_forecast);
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
