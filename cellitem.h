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
public:
    explicit CellItem(QColor color, QString symbol, bool checked,
                       QObject *parent = nullptr);
    explicit CellItem(QObject *parent = nullptr);

    QColor color() const;

    QString symbol() const;

    bool checked() const;
    void setChecked(bool checked);

signals:
    void CheckChanged();

private:
    QColor m_color;
    QString m_symbol;
    bool m_checked;

signals:

};

#endif // CELLITEM_H
