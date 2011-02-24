Qt.include("Database.js")

//get all weather infos for a certain location
function getWeather(locationID){
    var answer=[];
    var weatherIDs=getWeatherID(locationID);
    for(var i=0;i<weatherIDs.length;i++){
        answer[i]=getDataRow(weatherIDs[i],"Weather_Data");
    }
    return answer;
}


