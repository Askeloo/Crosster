#ifndef CELLITEM_H
#define CELLITEM_H

#include <QObject>
#include <QColor>
//#include <QQuickItem>

class CellItem : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QColor color READ color CONSTANT)
    Q_PROPERTY(QString symbol READ symbol CONSTANT)
    Q_PROPERTY(bool checked READ checked WRITE setChecked NOTIFY CheckChanged)
    Q_PROPERTY(bool highlighted READ highlighted
               WRITE setHighlighted NOTIFY HighlightedChanged)
public:
    explicit CellItem(QColor color = QColor("lightgreen"), QString symbol ="X",
                      bool highlighted = false, bool checked = false,
                      QObject *parent = nullptr);

    QColor color() const {return m_color;}

    QString symbol() const {return m_symbol;}

    bool highlighted() const {return m_highlighted;}
    void setHighlighted(bool highlighted);

    bool checked() const {return m_checked;}
    void setChecked(bool checked);

signals:
    void CheckChanged();
    void HighlightedChanged();

private:
    QColor m_color;
    QString m_symbol;
    bool m_highlighted;
    bool m_checked;

};

#endif // CELLITEM_H
