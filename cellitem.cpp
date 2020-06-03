#include "cellitem.h"

int CellItem::m_progress = 0;

CellItem::CellItem(QColor color, QString symbol, bool checked,
                   bool highlighted, QObject *parent)
    :QObject(parent),
      m_color(color),
      m_symbol(symbol),
      m_highlighted(highlighted),
      m_checked(checked)
{
    connect(this, &CellItem::CheckChanged, this, &CellItem::updateProgress);
}

void CellItem::setHighlighted(bool highlighted)
{
    m_highlighted = highlighted;

    emit HighlightedChanged(highlighted);
}


void CellItem::setChecked(bool checked)
{
    m_checked = checked;

    emit CheckChanged(checked);
}

void CellItem::updateProgress(bool progress)
{
    (progress) ? ++m_progress : --m_progress;
}

int CellItem::progress()
{
    return m_progress;
}



