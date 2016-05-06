#include "mainwindow.h"
#include <QApplication>

#include <QQuickView>
#include <QQuickItem>

#include <QFile>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    //    MainWindow w;
    //    w.show();

    QQuickView view;

    QFile init_file(":/schema.json");

    if(init_file.open(QIODevice::ReadOnly))
    {
        view.setResizeMode(QQuickView::SizeRootObjectToView);
        view.setSource(QUrl("qrc:/mtl_main.qml"));

        view.rootObject()->setProperty("json_init_data",
                                       init_file.readAll());

        view.show();
    }
    else
    {
        return 0;
    }

    return a.exec();
}
