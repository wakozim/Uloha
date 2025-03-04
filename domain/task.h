#ifndef TASK_H
#define TASK_H

#include <QString>

struct Task
{
    int id;
    QString title;
    QString description;
    //int tableId;
    bool completed;
};

#endif // TASK_H
