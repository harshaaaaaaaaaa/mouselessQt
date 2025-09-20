cmake_minimum_required(VERSION 3.16)

project(practice VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(apppractice
    main.cpp
)

qt_add_qml_module(apppractice
    URI practice
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES
        QML_FILES
        QML_FILES
        QML_FILES keydata.js
        QML_FILES utils/ShortcutView.qml
        QML_FILES utils/CategoryView.qml
        QML_FILES utils/AppsView.qml
        RESOURCES Resource.qrc
        QML_FILES
        QML_FILES utils/Testground.qml
        QML_FILES vstestdata.js
        QML_FILES utils/Result.qml
        QML_FILES utils/KeyAnalysis.qml
        QML_FILES
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(apppractice PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.apppractice
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(apppractice
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS apppractice
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
