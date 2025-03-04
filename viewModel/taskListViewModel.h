#ifndef TASKLISTVIEWMODEL_H
#define TASKLISTVIEWMODEL_H

#include <QObject>
#include <QAbstractItemModel>
#include <QVector>
#include "../domain/task.h"
#include "../data/taskRepository.h"
#include "../ui/taskListModel.h"
#include "taskFilterProxyModel.h"

class TaskListViewModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QAbstractItemModel* allTasksModel READ allTasksModel CONSTANT)
    Q_PROPERTY(QAbstractItemModel* activeTasksModel READ activeTasksModel CONSTANT)
    Q_PROPERTY(QAbstractItemModel* completedTasksModel READ completedTasksModel CONSTANT)

public:
    explicit TaskListViewModel(QObject *parent = nullptr);

    QAbstractItemModel *allTasksModel();
    QAbstractItemModel *activeTasksModel();
    QAbstractItemModel *completedTasksModel();

public slots:
    void load();
    void addTask(const QString &title, const QString &description);
    void removeTask(int id);
    void toggleCompleted(int id);

private:
    QVector<Task> m_tasks;
    TaskRepository m_repository;
    TaskListModel m_taskListModel;
    TaskFilterProxyModel m_activeTasksModel;
    TaskFilterProxyModel m_completedTasksModel;
};

#endif // TASKLISTVIEWMODEL_H
