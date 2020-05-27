#ifndef GUIMANAGER_H
#define GUIMANAGER_H

#include <QObject>

#include "celltablemodel.h"
#include "patternmaker.h"

class GUIManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QObject* cell_model READ cell_model CONSTANT)

public:
    explicit GUIManager(QObject* parent = nullptr);
    GUIManager(const GUIManager&) = delete;
    GUIManager& operator=(const GUIManager&) = delete;

    CellTableModel* cell_model();

    // theese functions must start from low letter
    //Q_INVOKABLE void createPattern();

signals:

private:
    CellTableModel m_cell_model;
};

#endif // GUIMANAGER_H
