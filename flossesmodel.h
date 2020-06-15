#ifndef FLOSSESMODEL_H
#define FLOSSESMODEL_H

#include <QObject>
#include <QAbstractListModel>

#include "rolesenum.h"
#include "flossitem.h"

class FlossesModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit FlossesModel(QObject *parent = nullptr);

    QHash<int, QByteArray> roleNames() const override {
        return {
            { Roles::FLOSS_ROLE, "floss" }
        };
    }
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;


    void setWholeData(QVector<FlossItem*> cont);

private:

    QVector<FlossItem*> m_flossesList;
};

#endif // FLOSSESMODEL_H
