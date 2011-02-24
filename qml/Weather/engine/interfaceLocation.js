var locationsDev =[
       {id: 1,
        name: "Cluj-Napoca",
        active: true
        },
       {id: 2,
        name: "Los Angeles",
        active: false
        },
       {id: 3,
        name: "Timisoara",
        active: false
        },
        {id: 4,
         name: "Medias",
         active: false
         },
        {id: 5,
         name: "Chicago",
         active: false
         },
        {id: 6,
         name: "Brasov",
         active: false
         },
        {id: 7,
         name: "Timisoara",
         active: false
         }];
var locations= {};

locations.list = function() {
    //for DEV just return locationsDev
    return locationsDev;
}
locations.count = function() {
    return locationsDev.length;
}
locations.get = function(index) {
    return locationsDev[index]
}
