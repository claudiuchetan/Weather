Qt.include("Database.js")

//returns the location set as current in the database
function getCurrentLocation()
{
    var answer= getDBCurrentLocation();
    return answer;
}


//list all locations
function listLocations(){
    var answer=[];
    answer = getTableData("Location");
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
    var locID=getDBLocationID(name,country);
    //if the location with the same name doesn't alerady exist in DB
    if (locID==0){
        var currentTime = new Date();
        //longitude and latitude temporarly set as 1 until getLocation is implemented
        setDBLocation(name, country, 1, 1, currentTime,"false")
    }
    else{
        window.popup.msg="Location already exists!";
        window.popup.state="on";
    }
}

function getLocationID(name,country)
{
    var answer=getDBLocationID(name,country);
    return answer;
}

function deleteLocationbyID(id){
    deleteDataRow(id,"Location");
    /*var answer=getWeatherID(id);
    var i=1;
    var numIds=answer.length;
    if (numIds>0){
    for (i=1;i<=numIds;i++){
        deleteDataRow(answer[i],"Weather_Data");
        }
    deleteDataRow(id,"Location_Weather");
    }*/
}

/*function deleteLocationbyName(name,country){
    var answer=deleteDBLocation(name,country);
    return answer;
}*/

function deleteLocationbyName(name){
    var answer=deleteDBLocation(name);
    return answer;
}

