#include "guimanager.h"

GUIManager::GUIManager(QObject *parent) : QObject(parent)
{
    //m_db.setUp();
}

CellsModel *GUIManager::cellModel()
{
    return &m_cellModel;
}

FlossesModel *GUIManager::flossModel()
{
    return &m_flossModel;
}

void GUIManager::createPattern()
{
    PatternMaker patternMaker(m_pi.flossBrand); //add pattern floss type constructor

    auto [vectCells, vectFlosses] = patternMaker.createPattern(m_pi);

    m_pi.threadsAmount = vectFlosses.size();
    m_cellModel.setWholeData(vectCells, m_pi.width, m_pi.height);
    m_flossModel.setWholeData(vectFlosses);

    //m_db.insertPatternInfo(m_pi);
            //setWhole flosses
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

