#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>

#include "OpenAndroidGallery.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    //app.setWindowIcon(QIcon(":/letter_S_red-32.png")); //not working

    qmlRegisterType<OpenAndroidGallery>("Apadana.OpenAndroidGallery", 1, 0, "OpenAndroidGallery");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
