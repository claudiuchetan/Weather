Qt.include("Database.js");

function initDB() {
    initialize();
    console.log("!!!!");
    setDBLocation("Iasi","Romania", "123", "456", "02/12/2011","true");
    setDBLocation("Cluj-Napoca","Romania", "123", "456", "02/12/2011","false");
    setDBLocation("Timisoara","Romania", "123", "456", "02/12/2011","false");
    setDBLocation("Medias","Romania", "123", "456", "02/12/2011","false");
    setDBLocation("Helsinki","Finland", "123", "456", "02/12/2011","false");
    setDBLocation("Mountain View","USA", "123", "456", "02/12/2011","false");
    setDBLocation("Burlington","USA", "123", "456", "02/12/2011","false");
    setDBLocation("Brasov","Romania", "123", "456", "02/14/2011","false")
}

function clean(){
    console.log("CLEAN");
    cleanDB();
}
function addLocation(name) {
    console.log("adding "+name);
    setDBLocation(name,"Romania", "123", "456", "02/12/2011","false");
}


function deleteLocation(name) {
    var db = getDatabase();
    var res="";

    db.transaction(function(tx) {
            var rs = tx.executeSql('DELETE FROM Location WHERE name=?;', [name]);
            if (rs.rowsAffected > 0) {
                res="OK";
            } else {
                console.log("!!!");
                res = "Unknown";     }  })
    return res;
}


