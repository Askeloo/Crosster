#ifndef PATTERNSMODEL_H
#define PATTERNSMODEL_H

#include <QObject>

class PatternsModel : public QObject
{
    Q_OBJECT
public:
    explicit PatternsModel(QObject *parent = nullptr);

signals:

};

#endif // PATTERNSMODEL_H
