#ifndef TASKLISTMODEL_H
#define TASKLISTMODEL_H

#include <QAbstractListModel>
#include <QVector>
#include "../domain/task.h"

class TaskListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        TitleRole,
        DescriptionRole,
        CompletedRole
    };

    explicit TaskListModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    void setTasks(const QVector<Task> &tasks);

private:
    QVector<Task> m_tasks;
};

#endif // TASKLISTMODEL_H
