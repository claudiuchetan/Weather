import QtQuick 1.0
import QtWebKit 1.0
import QtMobility.location 1.1
import "../engine/LocationData.js" as Location
import "Map.js" as MapData
import "components"

WebView {
    url: "Map.html"
    preferredWidth: 500
    preferredHeight: 600
    smooth: false
    javaScriptWindowObjects: QtObject {
            WebView.windowObjectName: "qml"

            function qmlCall() {
                return Location.listLocations();
            }
        }
}
