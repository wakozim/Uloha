#include "taskFilterProxyModel.h"
#include "../ui/taskListModel.h"

TaskFilterProxyModel::TaskFilterProxyModel(QObject *parent)
    : QSortFilterProxyModel(parent)
{
}

bool TaskFilterProxyModel::showCompleted() const
{
    return m_showCompleted;
}

void TaskFilterProxyModel::setShowCompleted(bool value)
{
    if (m_showCompleted == value)
        return;

    m_showCompleted = value;
    emit showCompletedChanged();

    invalidateFilter(); 
}

bool TaskFilterProxyModel::filterAcceptsRow(int sourceRow,
                                            const QModelIndex &sourceParent) const
{
    QModelIndex index = sourceModel()->index(sourceRow, 0, sourceParent);

    if (!index.isValid())
        return false;

    bool completed = index.data(TaskListModel::CompletedRole).toBool();

    return completed == m_showCompleted;
}
