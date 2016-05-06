#-------------------------------------------------
#
# Project created by QtCreator 2016-04-27T16:00:14
#
#-------------------------------------------------

QT       += core gui quick

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = mtl_mobile
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h

FORMS    += mainwindow.ui

DISTFILES += \
    main.qml \
    test_module.qml

RESOURCES += \
    mtl_mobile.qrc \
    res.qrc
