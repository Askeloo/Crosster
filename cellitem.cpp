#include "cellitem.h"

CellItem::CellItem(QColor color, QString symbol, bool checked,
                   QObject *parent)
    :QObject(parent),
      m_color(color),
      m_symbol(symbol),
      m_checked(checked)
{
}

CellItem::CellItem(QObject *parent)
    :QObject(parent),
      m_color(QColor("lightgreen")),
      m_symbol("X"),
      m_checked(false)
{
}

QColor CellItem::color() const
{
    return m_color;
}

QString CellItem::symbol() const
{
    return m_symbol;
}

bool CellItem::checked() const
{
    return m_checked;
}

void CellItem::setChecked(bool checked)
{
    m_checked = checked;

    emit CheckChanged();
}


