import QtQuick 1.0
import "components"

Item {
    y:30

    ListView {
        id: view
        anchors { fill: parent; bottomMargin: 30 }
        model:  locationsForecastModel;
        delegate:
            Row{
            ForecastWidget {
                width:body.width
                height:body.height
                locationName: name
                forecast: weatherData;
                z:10
            }
        }
        preferredHighlightBegin: 0;
        preferredHighlightEnd: 0
        highlightRangeMode: ListView.StrictlyEnforceRange
        orientation: ListView.Horizontal
        snapMode: ListView.SnapToItem
        flickDeceleration: 2000
    }
}
