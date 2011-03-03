#include <QtGui/QApplication>
#include <QLandmarkManager>
#include "qmlapplicationviewer.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/Weather/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
