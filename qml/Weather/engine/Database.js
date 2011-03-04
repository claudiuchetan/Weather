initialize();
function getDatabase() {
    return openDatabaseSync("WTFTeste1", "1.0", "StorageDatabase for weather application", 100000);
}

function initialize() {
    console.log("INITIALIZE");
    var db = getDatabase();
    db.transaction( function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Location(id INTEGER UNIQUE PRIMARY KEY, name TEXT,country TEXT, longitudine TEXT, latitude TEXT, date_added TIMESTAMP, current BOOL    )');
        tx.executeSql('CREATE TABLE IF NOT EXISTS Location_Weather(idWeather_Data INTEGER UNIQUE, idLocation INTEGER, type STRING )');
        tx.executeSql('CREATE TABLE IF NOT EXISTS Weather_Data(id INTEGER UNIQUE PRIMARY KEY, date DATETIME,temperature FLOAT, temp_min FLOAT, temp_max FLOAT, precipitation FLOAT, wind_speed FLOAT, humidity FLOAT, pressure FLOAT, weather_desc TEXT, date_forecast, code INTEGER, image_url TEXT )');
               });
}

function cleanDB() {
    var db = getDatabase();
    db.transaction( function(tx) {
        var rs=tx.executeSql('DROP DATABASE WTFTeste ');
                       if (rs.rowsAffected > 0) {
                           res="OK";
                       } else {
                           console.log("!!!Error cleaning DB");
                           res = "Unknown";     }
               });
}


/* Save location to DB */
function setDBLocation(name, country, longitude, latitude, date_added, current) {
    var db = getDatabase();
    var res = "";
    var id=0;
    //id = getNumRows("Location")+1;
    id=getMaxID("Location")+1;
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO Location VALUES (?,?,?,?,?,?,?);', [id, name, country, longitude, latitude, date_added, current]);
        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
        }  );
return res;
}

/* Save weather data to DB */
function setDBWeather(date, temp, temp_min, temp_max, precip, wind, humidity, presure,desc,date_forecast,code,image_url) {
    var db = getDatabase();
    var res = "";
    var id=0;
    id=getMaxID("Weather_Data")+1;
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT INTO Weather_Data VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?);', [id,date, temp, temp_min, temp_max, precip, wind, humidity, presure,desc,date_forecast,code,image_url])
        if (rs.rowsAffected > 0) {
            res = id;
        } else {
            res = "Error";
        }
        }  );
return res;
}

/* Save location-weather connection */
function setDBLocationWeather(idWeather, idLocation, type)
{
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT INTO Location_Weather VALUES (?,?,?);', [idLocation,idWeather,type]);
        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
        }  );
return res;
}

function getNumRows(table)
{
    var db = getDatabase();
    var res=0;
    var num=0;
    db.transaction(function(tx) {
    var rs = tx.executeSql('SELECT id FROM '+table+';');
    num=rs.rows.length;
        if (num >= 0) {
                res = num;
            } else {
                res = 0;     }  })
    return res;
}

function getMaxID(table)
{
    var db = getDatabase();
    var res=0;
    //var num=0;
    db.transaction(function(tx) {
    var rs = tx.executeSql('SELECT MAX(id) as MAXID FROM '+table+';');
    if (rs.rows.item(0).MAXID !=0){
        var res1 = rs.rows.item(0).MAXID;
        res=eval(res1);
     } else {
        res = 0;     }  })
    return res;
}

function getTableData(table){
    var db = getDatabase();
    var res=[];

    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM '+table+';');
            if (rs.rows.length > 0) {
                for (var i=0;i<rs.rows.length;i++)
                    res[i] = rs.rows.item(i);
            }
            })
return res;
}

function getDataRow(id, table) {
    var db = getDatabase();
    var res="";

    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM '+table+' WHERE id=?;', [id]);
            if (rs.rows.length > 0) {
                res = rs.rows.item(0);
            } else {
                res = "Unknown";     }  })
    return res;
}

/*gets the current set location in DB*/
function getDBCurrentLocation(){
    var db = getDatabase();
    var res="";

    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM Location WHERE current="true";');
            if (rs.rows.length > 0) {
                res = rs.rows.item(0);
            } else {
                res = "Unknown";     }  })
    return res;
}

/* Save location as current */
function setDBLocationAsCurrent(locationID, pastLocationId){
var db = getDatabase();
    var res1=""; var res2="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('UPDATE Location SET current="false" WHERE id=?;',[pastLocationId]);
        if (rs.rowsAffected > 0) {
            res1 = "OK";
            db.transaction(function(tx) {
                               var rs2 = tx.executeSql('UPDATE Location SET current="true" WHERE id=?;',[locationID]);
                if (rs2.rowsAffected > 0) {
                    res2 = "OK";
                } else {
                    res2 = "Error";
                }
                });
        } else {
            res1 = "Error";
        }
        }  );
    if ((res1=="Error") || (res2=="Error"))
    {
        return "Error"
    }
    else{
        return "OK";
    }
}

/* read ID of a location */
function getDBLocationID(name,country)
{
    var db = getDatabase();
    var res=0;

    db.transaction(function(tx) {
            var rs = tx.executeSql('SELECT id FROM Location WHERE name=? and country=?;',[name,country]);
            if (rs.rows.length > 0) {
                console.log(">>>>>>>>>>>");
                res = rs.rows.item(0).id;
            }   })
    return res;
}

function deleteDataRow(id, table) {
    var db = getDatabase();
    var res="";

    db.transaction(function(tx) {
            var rs = tx.executeSql('DELETE FROM '+table+' WHERE id=?;', [id]);
            if (rs.rowsAffected > 0) {
                res="OK";
            } else {
                console.log("!!!");
                res = "Unknown";     }  })
    return res;
}

 function getWeatherID(locationID,type){
    var db = getDatabase();
    var res=[];

    db.transaction(function(tx) {
            var rs = tx.executeSql('SELECT idWeather_Data FROM Location_Weather WHERE idLocation=? and type=?',[locationID,type]);
            if (rs.rows.length > 0) {
                for (var i=0;i<rs.rows.length;i++){
                    res[i] = rs.rows.item(i).idWeather_Data;
                }
            } else {
                res = -1;     }  })
    return res;
}

/*function deleteDBLocation(name,country) {
    var db = getDatabase();
    var res="";

    db.transaction(function(tx) {
            var rs = tx.executeSql('DELETE FROM Location WHERE name=? AND country=?;', [name,country]);
            if (rs.rowsAffected > 0) {
                res="OK";
            } else {
                res = "Unknown";     }  })
    return res;
}*/

function deleteDBLocation(name) {
    var db = getDatabase();
    var res="";

    db.transaction(function(tx) {
            var rs = tx.executeSql('DELETE FROM Location WHERE name=?;', [name]);
            if (rs.rowsAffected > 0) {
                res="OK";
            } else {
                res = "Unknown";     }  })
    return res;
}

function getAllWeatherID(locID){
    var db = getDatabase();
    var res=[];

    db.transaction(function(tx) {
            var rs = tx.executeSql('SELECT idWeather_Data FROM Location_Weather WHERE idLocation=? ',[locID]);
            if (rs.rows.length > 0) {
                for (var i=0;i<rs.rows.length;i++){
                    res[i] = rs.rows.item(i).idWeather_Data;
                }
            } else {
                res = -1;     }  })
    return res;
}

