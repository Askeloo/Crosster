#ifndef CELLTABLEMODEL_H
#define CELLTABLEMODEL_H


#include <array>
#include <QAbstractTableModel>
#include <QPoint>

#include "rolesenum.h"
#include "cellitem.h"


class CellsModel : public QAbstractTableModel
{
    Q_OBJECT
    //Q_ENUMS(Roles)

public:
    explicit CellsModel(QObject *parent = nullptr);

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
    void setWholeData(QVector<CellItem*> cont, size_t w, size_t h);
    void highlightColor(QColor colorToHL);
    void highlightCells(QColor colorToHL);

    double getProgress() {return m_scheme[0]->progress() / static_cast<double>(m_width * m_height);}

private:
    QPoint cellCoordinatesFromIndex(int cellIndex) const;
    std::size_t cellIndex(const QPoint &coordinates) const;

    QVector<CellItem*> m_scheme;

    QVector<int> m_hlIndecies;

    size_t m_width;
    size_t m_height;
};

#endif // CELLTABLEMODEL_H
