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

    var minLat = 180, minLon = 180, maxLat = -180, maxLon = -180, lat, lon, i, bottomRight = null, topLeft = null;
    for (i in markers) {
        lat = Number(markers[i].latitude);
        lon  = Number(markers[i].longitudine);
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
    }

    map.zoomTo(new ovi.mapsapi.geo.BoundingBox (new ovi.mapsapi.geo.Coordinate(Number(topLeft.latitude), Number(topLeft.longitudine)), new ovi.mapsapi.geo.Coordinate(Number(bottomRight.latitude), Number(bottomRight.longitudine))));

    for (var i in markers) {
        marker = new ovi.mapsapi.map.Marker(
                    new ovi.mapsapi.geo.Coordinate(Number(markers[i].latitude), Number(markers[i].longitudine)),{
                title: "marker",
                visibility: true,
                icon: "../images/smaller/sunny.png",
                //offset the top left icon corner so that it's centered above the coordinate
                anchor: new ovi.mapsapi.util.Point(16, 16)
        });
        map.objects.add(marker);
    }
}
