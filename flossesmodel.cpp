#include "flossesmodel.h"

FlossesModel::FlossesModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

int FlossesModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_flossesList.size();
}

QVariant FlossesModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || role != Roles::FLOSS_ROLE)
        return QVariant();

    return QVariant::fromValue(qobject_cast<QObject*>(m_flossesList[index.row()]));

}

void FlossesModel::setWholeData(QVector<FlossItem *> cont)
{
    if (!m_flossesList.isEmpty()) {
      beginRemoveRows(QModelIndex(), 0, m_flossesList.size() - 1);
      qDeleteAll(m_flossesList);  // deleting all elements
      m_flossesList.clear();      // removing all elements
      endRemoveRows();
    }

    m_flossesList = cont;
}
