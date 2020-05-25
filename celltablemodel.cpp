#include "celltablemodel.h"

#include <QFile>
#include <QTextStream>
#include <QRect>

CellTableModel::CellTableModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    m_currentState.resize(width * height);
}

int CellTableModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return height;
}

int CellTableModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return width;
}

QVariant CellTableModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || role != CellRole)
        return QVariant();

    return QVariant(m_currentState[cellIndex({index.column(), index.row()})]);
}

bool CellTableModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (role != CellRole || data(index, role) == value)
        return false;

    m_currentState[cellIndex({index.column(), index.row()})] = value.toBool();
    emit dataChanged(index, index, {role});

    return true;
}

Qt::ItemFlags CellTableModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}


QPoint CellTableModel::cellCoordinatesFromIndex(int cellIndex)
{
    return {cellIndex % width, cellIndex / width};
}

std::size_t CellTableModel::cellIndex(const QPoint &coordinates)
{
    return std::size_t(coordinates.y() * width + coordinates.x());
}
