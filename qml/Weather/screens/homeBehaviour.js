Qt.include("../engine/interfaceLocation.js");
Qt.include("../engine/interfaceWeather.js");

var startingBlock=0;

function scrollToLocation(currentElementPosition, screenWidth) {
    var elementVariationX=currentElementPosition-startingBlock * screenWidth;
    if (Math.abs(elementVariationX) > 100 ) {
        if (elementVariationX>0) {
            startingBlock++;
        } else {
            startingBlock--;
        }
    }
    return (startingBlock * screenWidth);
}

var weatherQueue=[];
