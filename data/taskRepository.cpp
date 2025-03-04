#include "taskRepository.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QVariant>
#include <QDebug>

TaskRepository::TaskRepository()
{
    if (!QSqlDatabase::contains("tasks_connection")) {
        m_db = QSqlDatabase::addDatabase("QSQLITE", "tasks_connection");
        m_db.setDatabaseName("tasks.db");
    } else {
        m_db = QSqlDatabase::database("tasks_connection");
    }
}

bool TaskRepository::init()
{
    if (!m_db.open()) {
        qDebug() << "DB open error:" << m_db.lastError();
        return false;
    }

    QSqlQuery query(m_db);

    QString createTable =
        "CREATE TABLE IF NOT EXISTS tasks (              "
        "  id INTEGER PRIMARY KEY AUTOINCREMENT,         "
        "  title TEXT NOT NULL,                          "
        "  description TEXT,                             "
        "  tableId INT,                                  "
        "  createdAt DATETIME DEFAULT CURRENT_TIMESTAMP, "
        "  completed BOOL NOT NULL DEFAULT 0             "
        ")                                               ";

    if (!query.exec(createTable)) {
        qDebug() << "Create table error:" << query.lastError();
        return false;
    }

    return true;
}

QVector<Task> TaskRepository::loadTasks()
{
    QVector<Task> tasks;

    QSqlQuery query(m_db);

    if (!query.exec("SELECT id, title, description, completed FROM tasks ORDER BY id DESC")) {
        qDebug() << "Select error:" << query.lastError();
        return tasks;
    }

    while (query.next()) {
        Task task;
        task.id = query.value("id").toInt();
        task.title = query.value("title").toString();
        task.description = query.value("description").toString();
        task.completed = query.value("completed").toBool();

        tasks.append(task);
    }

    return tasks;
}

bool TaskRepository::addTask(Task &task)
{
    QSqlQuery query(m_db);

    query.prepare("INSERT INTO tasks (title, description, completed) "
                  "VALUES (:title, :description, :completed)");

    query.bindValue(":title", task.title);
    query.bindValue(":description", task.description);
    query.bindValue(":completed", task.completed ? 1 : 0);

    if (!query.exec()) {
        qDebug() << "Insert error:" << query.lastError();
        return false;
    }

    task.id = query.lastInsertId().toInt();
    return true;
}

bool TaskRepository::removeTask(int id)
{
    QSqlQuery query(m_db);

    query.prepare("DELETE FROM tasks WHERE id = :id");
    query.bindValue(":id", id);

    if (!query.exec()) {
        qDebug() << "Delete error:" << query.lastError();
        return false;
    }

    return true;
}

bool TaskRepository::setCompleted(int id, bool completed)
{
    QSqlQuery query(m_db);

    query.prepare("UPDATE tasks SET completed = :completed WHERE id = :id");
    query.bindValue(":completed", completed ? 1 : 0);
    query.bindValue(":id", id);

    if (!query.exec()) {
        qDebug() << "Update error:" << query.lastError();
        return false;
    }

    return true;
}
