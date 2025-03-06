#ifndef TASKREPOSITORY_H
#define TASKREPOSITORY_H

#include <QSqlDatabase>
#include <QVector>
#include "../domain/task.h"

class TaskRepository
{
public:
    TaskRepository();

    bool init();
    QVector<Task> loadTasks();
    bool addTask(Task &task); 
    bool removeTask(int id);
    bool setCompleted(int id, bool completed);

private:
    QSqlDatabase m_db;
};

#endif // TASKREPOSITORY_H
