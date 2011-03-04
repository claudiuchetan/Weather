Qt.include("../engine/weatherIcons.js");
var currentWeatherQueue=[];
var forecastWeatherQueue=[];

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
                     "name": locations[i].name,
                     "id": locations[i].id,
                     "icon":icon});
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
    if (forecastWeatherQueue.length>0) {
        getForecastWeatherFromQueue(); }
}

function formatDate(date) {
    return date.substring(5,date.length);
}
