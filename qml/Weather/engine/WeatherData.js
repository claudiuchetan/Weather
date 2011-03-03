Qt.include("Database.js")

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
    console.log(query);
    return query;
}

function saveCurrentWeather(type,locID,temp,temp_min,temp_max,precip,wind,humidity,pressure,desc,date_forecast){
    //var usedTime=new Date();
    var cTime = new Date();
    var usedDate=formatTime(cTime);
    if (type=="current"){
        console.log("SAVE");
        var weatherID=setDBWeather(cTime.getTime(),temp,temp_min,temp_max,precip,wind,humidity,pressure,desc,usedDate);
        setDBLocationWeather(locID,weatherID, "current");
    }
    else{
        var weatherID=setDBWeather(cTime.getTime(),temp,temp_min,temp_max,precip,wind,humidity,pressure,desc,date_forecast);
        setDBLocationWeather(locID,weatherID, "forecast");
    }
    return weatherID;
}

function formatTime(currentTime){
    var month = currentTime.getMonth() + 1;
    var day = currentTime.getDate();
    var year = currentTime.getFullYear();
    var hours=currentTime.getHours();
    var minutes=currentTime.getMinutes();
    var seconds=currentTime.getSeconds();
    var time=year+"-"+month+"-"+day+""+hours+":"+minutes+":"+seconds;
    return time;

}

function verifyLastReq(locID,type){
    var wIDs=[];
    var wDatas=[];
    var cTime=new Date();
    var currentTime=cTime.getTime();
    var res1="";
    var res2=[];

    wIDs=getWeatherID(locID,type);
    if(wIDs != -1){ 
        for (var i=0;i<wIDs.length;i++){
            wDatas[i]=getDataRow(wIDs[i],"Weather_Data");
            var ttt= (wDatas[i].date);
            if (type=="current"){
                if (currentTime-ttt < 3600000){
                    res1=wDatas[i];
                    break;
                }
            }
            else {
                if (currentTime-ttt < 86400000){
                    res2[i]=wDatas[i];
                }
            }
        }
    }
if (type=="current")
    return res1
else
    return res2;
}

function getWeatherRow(id){
var answer="";
answer=getDataRow(id,"Weather_Data");
return answer;
}



