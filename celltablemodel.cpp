#include "celltablemodel.h"

#include <QFile>
#include <QTextStream>
#include <QRect>

CellTableModel::CellTableModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    //CellItem tempCell(QColor("lightgreen"), "X", false);
    CellContainer temp;
    m_width = 50;
    m_height = 70;
    for(size_t i = 0; i < m_width * m_height; i++)
    {
        CellItem* tempCell = new CellItem(QColor("lightgreen"), "X", false);
        temp.push_back(tempCell);
    }

    setWholeData(temp, m_width, m_height);
}

int CellTableModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_height;
}

int CellTableModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_width;
}

QVariant CellTableModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || role != Roles::CELL_ROLE)
        return QVariant();

    return QVariant::fromValue(qobject_cast<QObject*>(m_scheme[cellIndex({index.column(), index.row()})]));
}

void CellTableModel::setWholeData(CellTableModel::CellContainer cont, size_t w, size_t h)
{
    if (!m_scheme.isEmpty()) {
      beginRemoveRows(QModelIndex(), 0, m_scheme.size() - 1);
      qDeleteAll(m_scheme);  // deleting all elements
      m_scheme.clear();      // removing all elements
      endRemoveRows();
    }

    m_width = w;
    m_height = h;

    m_scheme = cont;
}

//bool CellTableModel::setData(const QModelIndex &index, const QVariant &value, int role)
//{
//    if (role != Roles::CELL_ROLE || data(index, role) == value)
//        return false;

//    m_currentState[cellIndex({index.column(), index.row()})] = value.toBool();
//    emit dataChanged(index, index, {role});

//    return true;
//}
/*
Qt::ItemFlags CellTableModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}*/


QPoint CellTableModel::cellCoordinatesFromIndex(int cellIndex) const
{
    QPoint p;
    p.setX(cellIndex % m_width);
    p.setY(cellIndex / m_width);
    return p;
}

std::size_t CellTableModel::cellIndex(const QPoint &coordinates) const
{
    return std::size_t(coordinates.y() * m_width + coordinates.x());
}
