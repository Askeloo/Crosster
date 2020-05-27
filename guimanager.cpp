#include "guimanager.h"

GUIManager::GUIManager(QObject *parent) : QObject(parent)
{

}

CellTableModel *GUIManager::cell_model()
{
    return &m_cell_model;
}
