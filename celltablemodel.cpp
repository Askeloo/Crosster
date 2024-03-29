#include "celltablemodel.h"

#include <QFile>
#include <QTextStream>
#include <QRect>

CellsModel::CellsModel(QObject *parent)
    : QAbstractTableModel(parent)
{

}

int CellsModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_height;
}

int CellsModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_width;
}

QVariant CellsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || role != Roles::CELL_ROLE)
        return QVariant();

    return QVariant::fromValue(qobject_cast<QObject*>(m_scheme[cellIndex({index.column(), index.row()})]));
}

void CellsModel::setWholeData(QVector<CellItem*> cont, size_t w, size_t h)
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

void CellsModel::highlightColor(QColor colorToHL)
{
    if(m_hlIndecies.empty())  //there aren't any highlightings
    {
        highlightCells(colorToHL);
    }
    else
    {
        QColor hlColor = m_scheme[m_hlIndecies[0]]->color();
        for(const int& i : m_hlIndecies)
        {
            m_scheme[i]->setHighlighted(false);
        }
        m_hlIndecies.clear();

        if(colorToHL != hlColor)  //slected another color to highlight
        {
            highlightCells(colorToHL);
        }
    }
}

void CellsModel::highlightCells(QColor colorToHL)
{
    for(int i = 0; i < m_scheme.size(); i++)
    {
        if(m_scheme[i]->color() == colorToHL)
        {
            m_scheme[i]->setHighlighted(true);
            m_hlIndecies.push_back(i);
        }
    }
}


QPoint CellsModel::cellCoordinatesFromIndex(int cellIndex) const
{
    QPoint p;
    p.setX(cellIndex % m_width);
    p.setY(cellIndex / m_width);
    return p;
}

std::size_t CellsModel::cellIndex(const QPoint &coordinates) const
{
    return std::size_t(coordinates.y() * m_width + coordinates.x());
}
