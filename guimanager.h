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
    Q_PROPERTY(unsigned threadsAmount READ threadsAmount WRITE setThreadsAmount)
    Q_PROPERTY(double progress READ progress CONSTANT)

public:
    explicit GUIManager(QObject* parent = nullptr);
    GUIManager(const GUIManager&) = delete;
    GUIManager& operator=(const GUIManager&) = delete;

    CellsModel* cellModel();

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
    void setThreadsAmount(unsigned ta)   {m_pi.threadsAmount = ta;}
    unsigned threadsAmount() const       {return m_pi.threadsAmount;}
    void setProgress(const double &progress)  {m_progress = progress;}
    double progress() const {return m_progress;    }

signals:

public slots:
    // theese functions must start from low letter
    void createPattern();
    void highlight(QColor colorToHL);
    void updateProgress();

private:
    PatternInfo m_pi;

    PatternMaker m_patternMaker;  //delete from guiManager

    //models
    CellsModel m_cellModel;
//    FlossesModel m_flossesModel;
//    PatternsModel m_patternsModel;
    double m_progress;
};

#endif // GUIMANAGER_H
