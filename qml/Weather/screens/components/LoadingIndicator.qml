import Qt 4.7

Item {
    id: root
    width: 30
    height: 30

    PathView {
        id: loadingWheel
        model: 8

        interactive: false

        PropertyAnimation {
            target: loadingWheel
            property: "offset"
            running: true
            loops: Animation.Infinite
            from: 0.0
            to: 6.0
            duration: 2000
        }

        path: Path {
             startX: 0; startY: 0
             PathAttribute { name: "elemColor"; value: 0.5 }
             PathQuad { x: root.width; y: 0; controlX: root.width/2; controlY: -root.height/2 }
             PathQuad { x: root.width; y: root.height; controlX: root.width*1.5; controlY: root.height/2 }
             PathAttribute { name: "elemColor"; value: 0.9 }
             PathQuad { x: 0; y: root.height; controlX: root.width/2; controlY: root.height * 1.5 }
             PathQuad { x: 0; y: 0; controlX: -root.width/2; controlY: root.height/2 }
        }

        delegate: Rectangle {
            width: root.width / 2.5
            height: root.height / 2.5
            radius: root.width / 5
            color: Qt.hsla(0.568, 0.15, PathView.elemColor, 1.0);
        }
    }

    Rectangle {
        id: pulsor
        anchors.centerIn: parent
        width: root.width / 1.5
        height: root.height / 1.5
        radius: root.width / 3
        color: "#a5b5ba"
        smooth: true

        SequentialAnimation {
            running: true
            loops: Animation.Infinite

            PropertyAnimation {
                target: pulsor
                property: "scale"
                from: 1.0
                to: 1.4
                duration: 500
                easing.type: "OutQuad"
            }

            PauseAnimation { duration: 200 }

            PropertyAnimation {
                target: pulsor
                property: "scale"
                from: 1.4
                to: 1.0
                duration: 500
                easing.type: "InQuad"
            }
        }
    }
}
