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
    cleanDB();
}

