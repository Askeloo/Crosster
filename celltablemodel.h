#ifndef CELLTABLEMODEL_H
#define CELLTABLEMODEL_H


#include <array>
#include <QAbstractTableModel>
#include <QPoint>

//! [modelclass]
class CellTableModel : public QAbstractTableModel
{
    Q_OBJECT

    Q_ENUMS(Roles)
public:
    enum Roles {
        CellRole
    };

    QHash<int, QByteArray> roleNames() const override {
        return {
            { CellRole, "value" }
        };
    }

    explicit CellTableModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex &index) const override;

private:
    static constexpr int width = 20;
    static constexpr int height = 30;
    static constexpr int size = width * height;

    using StateContainer = std::array<bool, size>;
    StateContainer m_currentState;

    static QPoint cellCoordinatesFromIndex(int cellIndex);
    static std::size_t cellIndex(const QPoint &coordinates);
};

#endif // CELLTABLEMODEL_H
