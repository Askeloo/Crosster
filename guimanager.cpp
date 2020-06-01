#include "guimanager.h"

GUIManager::GUIManager(QObject *parent) : QObject(parent)
{

}

CellTableModel *GUIManager::cellModel()
{
    return &m_cellModel;
}

void GUIManager::createPattern()
{
    auto vectCells = m_patternMaker.createPattern(m_pi);
    m_cellModel.setWholeData(vectCells, m_pi.width, m_pi.height);
}
