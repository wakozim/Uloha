#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "viewModel/taskListViewModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    TaskListViewModel vm;
    vm.load();

    engine.rootContext()->setContextProperty("taskVM", &vm);

    qmlRegisterSingletonType(QUrl("qrc:/qt/qml/Uloha/qml/Palette.qml"), "Uloha", 1, 0, "Palette");
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection
    );
    engine.loadFromModule("Uloha", "Main");

    return app.exec();
}
