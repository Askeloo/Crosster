#include "OpenAndroidGallery.h"

#include <QtAndroidExtras/QAndroidJniObject>
#include <QCoreApplication>
#include <QFile>
#include <QDebug>
#include <QtAndroid>

QString selectedFileName;

#ifdef __cplusplus
extern "C" {
#endif

JNIEXPORT void JNICALL
Java_org_qtproject_example_QtAndroidGallery_fileSelected(JNIEnv */*env*/,
                                                             jobject /*obj*/,
                                                             jstring results)
{
    selectedFileName = QAndroidJniObject(results).toString();
}

#ifdef __cplusplus
}
#endif


OpenAndroidGallery::OpenAndroidGallery(QObject *parent) : QObject(parent)
{

}

void OpenAndroidGallery::openGallery()
{
    const QVector<QString> permissions({"android.permission.WRITE_EXTERNAL_STORAGE"});

    for(const QString &permission : permissions){
        auto result = QtAndroid::checkPermission(permission);
        if(result == QtAndroid::PermissionResult::Denied){
            auto resultHash = QtAndroid::requestPermissionsSync(QStringList({permission}));
            if(resultHash[permission] == QtAndroid::PermissionResult::Denied)
            {
                //return 0;
            }
        }
    }



    selectedFileName = "#";
    QAndroidJniObject::callStaticMethod<void>("org/qtproject/example/QtAndroidGallery",
                                              "openAnImage",
                                              "()V");

    while(selectedFileName == "#")
        qApp->processEvents();

    if(QFile(selectedFileName).exists())
    {
        qDebug() << "selectedFileName   ;;  " <<  selectedFileName ;
        emit sigSendPath(selectedFileName);
    }

}
