#include "taskListModel.h"

TaskListModel::TaskListModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int TaskListModel::rowCount(const QModelIndex &) const
{
    return m_tasks.size();
}

QVariant TaskListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_tasks.size()) {
        return {};
    }

    const Task &task = m_tasks.at(index.row());

    switch (role) {
    case IdRole: return task.id;
    case TitleRole: return task.title;
    case DescriptionRole: return task.description;
    case CompletedRole: return task.completed;
    default: return {};
    }
}

QHash<int, QByteArray> TaskListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[TitleRole] = "title";
    roles[DescriptionRole] = "description";
    roles[CompletedRole] = "completed";
    return roles;
}

void TaskListModel::setTasks(const QVector<Task> &tasks)
{
    beginResetModel();
    m_tasks = tasks;
    endResetModel();
}
