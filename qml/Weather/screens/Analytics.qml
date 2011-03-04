import QtQuick 1.0
import QtWebKit 1.0

WebView {
    url: "http://www.worldweatheronline.com/feed/weather.ashx?q=paris,france&format=xml&num_of_days=1&key=3d571c8060200122110802"
    preferredWidth: 500
    preferredHeight: 640
    smooth: false
}
