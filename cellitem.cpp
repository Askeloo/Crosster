#include "cellitem.h"

CellItem::CellItem(QColor color, QString symbol, bool checked,
                   bool highlighted, QObject *parent)
    :QObject(parent),
      m_color(color),
      m_symbol(symbol),
      m_highlighted(highlighted),
      m_checked(checked)
{
}

void CellItem::setHighlighted(bool highlighted)
{
    m_highlighted = highlighted;

    emit HighlightedChanged();
}


void CellItem::setChecked(bool checked)
{
    m_checked = checked;

    emit CheckChanged();
}



