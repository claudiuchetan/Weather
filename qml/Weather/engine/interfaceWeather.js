Qt.include("../engine/weatherIcons.js");
var weatherDev =[
       {id: 1,
        name: "cloudy",
        degrees: 26,
        icon:weatherIcon.cloudy
        },
       {id: 2,
        name: "cloudy_night",
        degrees: 20,
        icon:weatherIcon.cloudy_night
        },
       {id: 3,
        name: "rain",
        degrees: 18,
        icon:weatherIcon.rain
        },
        {id: 4,
         name: "clouds",
         degrees: 21,
         icon:weatherIcon.clouds
         },
        {id: 5,
         name: "clear_night",
         degrees: 17,
         icon:weatherIcon.clear_night
         },
        {id: 6,
         name: "clear",
         degrees: 14,
         icon:weatherIcon.cloudy
         },
        {id: 7,
         name: "clouds_night",
         degrees: 13,
         icon:weatherIcon.clouds_night
         }];
var weather= {};

weather.get = function(index) {
        return weatherDev[index];
}
