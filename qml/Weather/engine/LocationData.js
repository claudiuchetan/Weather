Qt.include("Database.js")

//returns the location set as current in the database
function getCurrentLocation()
{
    var answer= getDBCurrentLocation();
    return answer;
}


//list all locations
function listLocations(){
    var i=1;
    var numLocations=getNumRows("Location");
    var answer=[];
    for (i=1;i<=numLocations;i++){
        answer[i-1]=getDataRow(i,"Location");

    }
    return answer;
}

//set current location as CURRENT in DB
function setCurrentLocation(locationID){
 var cLocationID= getCurrentLocation.id;
    if (locationID != cLocationID){
        setDBLocationAsCurrent(locationID,cLocationID);
    }

}


//add location in DB witha  name and country
function addLocation(name, country){
    var currentTime = new Date();
    //longitude and latitude temporarly set as 1 until getLocation is implemented
    setDBLocation(name, country, 1, 1, currentTime,"false")
}

function getLocationID(name,country)
{
    var answer=getDBLocationID(name,country);
    return answer;
}

function deleteLocation(id){
    deleteDataRow(id,"Location");
    var answer=getWeatherID(id);
    var i=1;
    var numIds=answer.length;
    if (numIds>0){
    for (i=1;i<=numIds;i++){
        deleteDataRow(answer[i],"Weather_Data");
        }
    deleteDataRow(id,"Location_Weather");
    }
}

// read weather data for location id and type:current, forecast
function createQueryString(locationID,type){
    var numDays=0;
    var key="3d571c8060200122110802";
    var answer=getDataRow(locationID,"Location");
    var city=answer.name;
    var country=answer.country;
    if (type=="current"){
        numDays=1;
    }
    else{
        numDays=5;
    }
    var query=city+","+country+"&format=xml&num_of_days="+numDays+"&key="+key;
    return query;
}
