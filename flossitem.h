#ifndef FLOSSITEM_H
#define FLOSSITEM_H

#include <QObject>
#include <QColor>

class FlossItem : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QColor color READ color CONSTANT)
    Q_PROPERTY(QString id READ id CONSTANT)
    Q_PROPERTY(QString descr READ descr CONSTANT)
    Q_PROPERTY(QString symbol READ symbol CONSTANT)
    Q_PROPERTY(unsigned amount READ amount CONSTANT)

public:
    explicit FlossItem(QColor c = "FFFFFF", QString i = "B5200",
                       QString d = "Snow White", QString s = "?",
                       unsigned n = 0, QObject *parent = nullptr)
        : m_color(c), m_id(i), m_descr(d), m_symbol(s), m_amount(n) {}


    QColor color() const
    {
        return m_color;
    }

    QString id() const
    {
        return m_id;
    }

    QString descr() const
    {
        return m_descr;
    }

    QString symbol() const
    {
        return m_symbol;
    }

    unsigned amount() const
    {
        return m_amount;
    }
    void incrAmount()
    {
        ++m_amount;
    }

    bool operator<(const FlossItem & b)    //TO DELETE
    {
       return m_amount < b.m_amount;
    }

signals:


private:
    QColor m_color;
    QString m_id;
    QString m_descr;
    QString m_symbol;
    unsigned m_amount;

};

#endif // FLOSSITEM_H
