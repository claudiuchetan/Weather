import QtQuick 1.0
import "components"

Item {
    y:30
    Row {
        id:days
        y:body.height-140
        x:20
        Repeater {
            model:5
            AnalyticsSeparator {
                pDay:window.getLogic().getForecastDay(index);
            }
        }
    }
    Rectangle {
        width:parent.width-20
        anchors.right: parent.right
        height:parent.height
        color:"#00000000"
        Repeater {
            id:bars
            model:4
            Rectangle {
                width:65
                height:parent.height-130
                y:50
                x:{return 65*index }
                color:"#00000000"
                Rectangle {
                    width:1
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    color:"#999"
                }
            }
        }
    }
    ListView {
        id: view
        anchors { fill: parent; bottomMargin: 30 }
        model:  locationsForecastModel;
        delegate:
            Row{
            AnalyticsWidget {
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
        y:50
    }
    Hr {
        anchors.bottom: days.top
        anchors.bottomMargin: 5
    }
}
