#include "taskListViewModel.h"

TaskListViewModel::TaskListViewModel(QObject *parent)
    : QObject(parent),
      m_taskListModel(this),
      m_activeTasksModel(this),
      m_completedTasksModel(this)
{
    m_repository.init();

    m_activeTasksModel.setSourceModel(&m_taskListModel);
    m_activeTasksModel.setShowCompleted(false);

    m_completedTasksModel.setSourceModel(&m_taskListModel);
    m_completedTasksModel.setShowCompleted(true);
}

QAbstractItemModel *TaskListViewModel::allTasksModel()
{
    return &m_taskListModel;
}

QAbstractItemModel *TaskListViewModel::activeTasksModel()
{
    return &m_activeTasksModel;
}

QAbstractItemModel *TaskListViewModel::completedTasksModel()
{
    return &m_completedTasksModel;
}

void TaskListViewModel::load()
{
    m_tasks = m_repository.loadTasks();
    m_taskListModel.setTasks(m_tasks);
}

void TaskListViewModel::addTask(const QString &title, const QString &description)
{
    Task task;
    task.id = -1;
    task.title = title;
    task.description = description;
    task.completed = false;

    m_repository.addTask(task);
    load();
}

void TaskListViewModel::removeTask(int id)
{
    m_repository.removeTask(id);
    load();
}

void TaskListViewModel::toggleCompleted(int id)
{
    for (Task &task : m_tasks) {
        if (task.id == id) {
            const bool newState = !task.completed;
            m_repository.setCompleted(id, newState);
            load();
            return;
        }
    }
}
