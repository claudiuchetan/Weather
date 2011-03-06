import QtQuick 1.0
import "components"

Item {
    y:30
    Column {
        y:60
    Repeater {
        model:5
            ForecastSeparator {
                pDay:window.getLogic().getForecastDay(index);
            }
        }
    }
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

    Hr {
        id:hr
        y:50
    }
}
