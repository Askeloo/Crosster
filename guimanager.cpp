#include "guimanager.h"

GUIManager::GUIManager(QObject *parent) : QObject(parent)
{

}

CellsModel *GUIManager::cellModel()
{
    return &m_cellModel;
}

void GUIManager::createPattern()
{
    auto [vectCells, threadsAmount] = m_patternMaker.createPattern(m_pi);

    m_pi.threadsAmount = threadsAmount;
    m_cellModel.setWholeData(vectCells, m_pi.width, m_pi.height);
}

void GUIManager::highlight(QColor colorToHL)
{
    m_cellModel.highlightColor(colorToHL);
}

void GUIManager::updateProgress()
{
    double p = m_cellModel.getProgress();
    setProgress(p);
}

