var map;
var markers;

function initMap() {
    markers = window.qml.qmlCall();

    map = new ovi.mapsapi.map.Display(document.getElementById("map"), {
        zoomLevel: 18,
        center: [46.776968, 23.614873]
    });

    map.addComponent( new ovi.mapsapi.map.component.zoom.DoubleClick() );
    map.addComponent( new ovi.mapsapi.map.component.panning.Drag() );
    map.addComponent( new ovi.mapsapi.map.component.ZoomBar() );
    map.addComponent( new ovi.mapsapi.map.component.TypeSelector() );

    var searchType="geocode";
            var searchTerm,
                    prox = {
                        center: new ovi.mapsapi.geo.Coordinate(52.5, 13.3333),
                        radius: 1200
                    },
                    bbox = new ovi.mapsapi.geo.BoundingBox(
                        new ovi.mapsapi.geo.Coordinate(50.1146125793467, 8.68348503112893),
                        new ovi.mapsapi.geo.Coordinate(50.07635498046865, 8.517169952392568)
                    );


    var minLat = 180, minLon = 180, maxLat = -180, maxLon = -180, lat, lon, i, bottomRight = null, topLeft = null;
    for (i in markers) {
        var city=markers[i].name;
        var country=markers[i].country;
        var searchManager = new ovi.mapsapi.search.Manager();
            searchManager.addObserver("state", function(observedManager, key, value) {
                if(value == "finished") {
                    if (observedManager.locations.length > 0) {
                        var lat=observedManager.locations[0].displayPosition.latitude;
                        var lon=observedManager.locations[0].displayPosition.longitude;
                        if (lat <= minLat && lon >= maxLon) {
                            minLat = lat;
                            maxLon = lon;
                            bottomRight = markers[i];
                        }
                        if (lat >= maxLat && lon <= minLon) {
                            maxLat = lat;
                            minLon = lon;
                            topLeft = markers[i];
                        }
                map.zoomTo(new ovi.mapsapi.geo.BoundingBox (new ovi.mapsapi.geo.Coordinate(Number(topLeft.latitude), Number(topLeft.longitudine)), new ovi.mapsapi.geo.Coordinate(Number(bottomRight.latitude), Number(bottomRight.longitudine))));
                marker = new ovi.mapsapi.map.Marker(
                new ovi.mapsapi.geo.Coordinate(Number(lat), Number(lon)),{
                title: "marker",
                visibility: true,
                icon: "../images/small_icons/sun.png",
                //offset the top left icon corner so that it's centered above the coordinate
                anchor: new ovi.mapsapi.util.Point(16, 16)
                });
        map.objects.add(marker);
                           }
                       } else if(value == "failed") {
                           alert("The request failed.");
                       }
                   });

                   if (searchType == "geocode") {
                       searchTerm = city +" "+country;
                       //make a geocode request
                       //searchManager.geocode(searchTerm);
                       searchManager.geocode(searchTerm, prox);
                   }
    }
}
