#ifndef TASKFILTEERMODEL_H
#define TASKFILTEERMODEL_H

#include <QSortFilterProxyModel>

class TaskFilterProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(bool showCompleted READ showCompleted WRITE setShowCompleted NOTIFY showCompletedChanged)

public:
    explicit TaskFilterProxyModel(QObject *parent = nullptr);

    bool showCompleted() const;
    void setShowCompleted(bool value);

signals:
    void showCompletedChanged();

protected:
    bool filterAcceptsRow(int sourceRow,
                          const QModelIndex &sourceParent) const override;

private:
    bool m_showCompleted = false;
};

#endif // TASKFILTEERMODEL_H
