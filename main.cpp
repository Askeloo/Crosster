#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>

#include "OpenAndroidGallery.h"
#include "celltablemodel.h"
#include "guimanager.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    //app.setWindowIcon(QIcon(":/letter_S_red-32.png")); //not working


    qmlRegisterType<OpenAndroidGallery>("Askelo.OpenAndroidGallery", 1, 0, "OpenAndroidGallery");
    //qmlRegisterType<CellTableModel>("CellTableModel", 1, 0, "CellTableModel");

    GUIManager guiManager;
    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("guiManager", &guiManager);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);


//    QString path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
//    if(QFile("/storage/emulated/0/org.askelo.crosster/files/dmc.csv").exists())
//    {
//    }

    return app.exec();
}
