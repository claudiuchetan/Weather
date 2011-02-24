import QtQuick 1.0
import "../screens/components"

Rectangle {
    color:"#69F"
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Forecast"
    }

    XmlListModel {
        id:forecastModel
        source:"http://www.worldweatheronline.com/feed/weather.ashx?q=Cluj,Romania&format=xml&num_of_days=2&key=3d571c8060200122110802"
        query: "/data/current_condition"
        XmlRole { name: "temperature"; query: "temp_C/number()" }
        XmlRole { name: "weather"; query: "weatherDesc/string()" }
        XmlRole { name: "windspeed"; query: "windspeedKmph/number()" }
        XmlRole { name: "precipitation"; query: "precipMM/number()" }
        XmlRole { name: "humidity"; query: "humidity/number()" }
        XmlRole { name: "visibility"; query: "visibility/number()" }
        XmlRole { name: "pressure"; query: "pressure/number()" }
        XmlRole { name: "cloudcover"; query: "cloudcover/number()" }

        onStatusChanged: {
            if (status == XmlListModel.Ready) {
                console.log("ok "+forecastModel.get(0).temperature);
            }
        }
    }

    Loader {
        width:360
        height:400
        sourceComponent: forecastModel.status===XmlListModel.Ready?listing:loading;
    }

    Component {
        id: loading
        Item {
            LoadingIndicator {
                width: 50
                height: 50
                anchors.centerIn: parent
            }
        }
    }
    Component {
        id:listing
        ListView {
            model: forecastModel
            width: 180; height: 300
            delegate: Text { text:  temperature + ": " + weather }
        }
    }

    Component.onCompleted:{
        console.log("-> Forecast loaded");
    }
}
