import QtQuick 1.0
import "components"

Item {
    y:30

    ListView {
        id: view
        anchors { fill: parent; bottomMargin: 30 }
        model:  locationsModel;
        delegate:
            Row{
            WeatherWidget {
                width:body.width
                height:body.height
                locationName: city
                nightMode:night
                temperature: (degrees=="")?"":(degrees+"\u00B0C")
                weatherState: description
                iconSrc: (icon=="")?"":icon.src
                iconWidth: (icon=="")?0:icon.width
                iconHeight: (icon=="")?0:icon.height
                z:10
            }
        }
        preferredHighlightBegin: 0;
        preferredHighlightEnd: 0
        highlightRangeMode: ListView.StrictlyEnforceRange
        orientation: ListView.Horizontal
        snapMode: ListView.SnapToItem
        flickDeceleration: 2000
        currentIndex: window.currentLocation-1
    }

    Hr {
        y:240
        z:12
    }
}
