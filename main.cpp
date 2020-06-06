#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include <QQuickStyle>

#include "OpenAndroidGallery.h"
#include "celltablemodel.h"
#include "guimanager.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<OpenAndroidGallery>("Askelo.OpenAndroidGallery", 1, 0, "OpenAndroidGallery");

    GUIManager guiManager;
    QQmlApplicationEngine engine;

    QQuickStyle::setStyle("Material");
    engine.rootContext()->setContextProperty("guiManager", &guiManager);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
