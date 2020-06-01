#ifndef CELLTABLEMODEL_H
#define CELLTABLEMODEL_H


#include <array>
#include <QAbstractTableModel>
#include <QPoint>

#include "rolesenum.h"
#include "cellitem.h"


//! [modelclass]
class CellTableModel : public QAbstractTableModel
{
    Q_OBJECT
    //Q_ENUMS(Roles)

    using CellContainer = QVector<CellItem*>;

public:
    explicit CellTableModel(QObject *parent = nullptr);

    QHash<int, QByteArray> roleNames() const override {
        return {
            { Roles::CELL_ROLE, "cell" }
        };
    }
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
//    bool setData(const QModelIndex &index, const QVariant &value,
//                 int role = Qt::EditRole) override;

//    Qt::ItemFlags flags(const QModelIndex &index) const override;
    void setWholeData(CellContainer cont, size_t w, size_t h);

private:
    size_t m_width;
    size_t m_height;

    CellContainer m_scheme;

    QPoint cellCoordinatesFromIndex(int cellIndex) const;
    std::size_t cellIndex(const QPoint &coordinates) const;
};

#endif // CELLTABLEMODEL_H
