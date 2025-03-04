cmake_minimum_required(VERSION 3.16)

project(Uloha VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Sql)

qt_standard_project_setup(REQUIRES 6.8)

set(sources main.cpp)
qt_add_resources(sources images.qrc)

set_source_files_properties(qml/Palette.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_executable(appuloha
    ${sources} 
)


#set_source_files_properties(Palette.qml PROPERTIES QT_RESOURCE_ALIAS Palette.qml)

qt_add_qml_module(appuloha
    URI Uloha 

    QML_FILES
        qml/Palette.qml
        qml/Main.qml
        qml/components/MainMenu.qml
        qml/components/MenuIconLive.qml
        qml/components/MyPage.qml
        qml/TasksPage.qml
        qml/NewTaskPage.qml
        qml/SettingsPage.qml
        qml/AboutPage.qml

    SOURCES 
        domain/task.h
        data/taskRepository.h
        data/taskRepository.cpp
        viewModel/taskListViewModel.h
        viewModel/taskListViewModel.cpp
        viewModel/taskFilterProxyModel.h
        viewModel/taskFilterProxyModel.cpp
        ui/taskListModel.h
        ui/taskListModel.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appuloha PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appuloha
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appuloha
    PRIVATE 
        Qt6::Core
        Qt6::Quick
        Qt6::Sql
)

include(GNUInstallDirs)
install(TARGETS appuloha
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
