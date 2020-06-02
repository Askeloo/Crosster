#ifndef GUIMANAGER_H
#define GUIMANAGER_H

#include <QObject>

#include "celltablemodel.h"
#include "patternmaker.h"

class GUIManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QObject* cell_model READ cellModel CONSTANT)
    //selected color var will be in qml

    // should add READ config for aboutPattern page
    Q_PROPERTY(QString name READ name WRITE setName)
    Q_PROPERTY(QString imagePath READ imagePath WRITE setImagePath)
    Q_PROPERTY(QString flossBrand READ flossBrand WRITE setFlossBrand)
    Q_PROPERTY(unsigned width READ width WRITE setWidth)
    Q_PROPERTY(unsigned height READ height WRITE setHeight)
    Q_PROPERTY(unsigned maxColors READ maxColors WRITE setMaxColors)

public:
    explicit GUIManager(QObject* parent = nullptr);
    GUIManager(const GUIManager&) = delete;
    GUIManager& operator=(const GUIManager&) = delete;

    CellTableModel* cellModel();

    void setName(QString name) { m_pi.name = name; }
    QString name() const       { return m_pi.name; }
    void setImagePath(QString imagePath) {m_pi.image.load(imagePath);} //slow operation
    QString imagePath() const            {return  QString();} //FIXME
    void setFlossBrand(QString flossBrand) {m_pi.flossBrand = flossBrand;}
    QString flossBrand() const             {return m_pi.flossBrand;}
    void setWidth(unsigned w)  {m_pi.width = w;}
    unsigned width() const     {return m_pi.width;}
    void setHeight(unsigned h)  {m_pi.height = h;}
    unsigned height() const     {return m_pi.height;}
    void setMaxColors(unsigned maxColors)   {m_pi.maxColors = maxColors;}
    unsigned maxColors() const              {return m_pi.maxColors;}

signals:

public slots:
    // theese functions must start from low letter
    void createPattern();
    void highlight(QColor colorToHL);

private:
    PatternInfo m_pi;

    PatternMaker m_patternMaker;  //delete from guiManager

    //models
    CellTableModel m_cellModel;

    unsigned m_progress;
};

#endif // GUIMANAGER_H
