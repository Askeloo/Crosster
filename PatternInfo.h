#ifndef PATTERNINFO_H
#define PATTERNINFO_H

#include <QString>
#include <QImage>

struct PatternInfo {

    PatternInfo() = default;
    PatternInfo(const PatternInfo&) = default;

    QImage image;
    QString name;
    QString flossBrand;
    unsigned width, height;
    unsigned maxColors;
    unsigned threadsAmount;
};

#endif // PATTERNINFO_H
