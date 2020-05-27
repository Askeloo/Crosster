#ifndef PATTERNMAKER_H
#define PATTERNMAKER_H

#include <QString>
#include <QColor>
#include <QVector>
#include <QFile>

class PatternMaker
{
    struct FlossData
    {
    public:
        FlossData() = default;
        FlossData(QString i, QString d, QString c)
            : id(i), descr(d), color("#" + c) {}

        QString id;
        QString descr;
        QColor color;
    };


public:
    PatternMaker();

private:
    QVector<FlossData> m_flosses;
};

#endif // PATTERNMAKER_H
