cmake_minimum_required(VERSION 3.16)

project(practice VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

# Find X11 for Linux active window detection and global shortcuts
if(UNIX AND NOT APPLE)
    find_package(X11)
    find_package(Qt6 COMPONENTS Gui REQUIRED)
endif()

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(apppractice
    main.cpp
    userdatamanager.h
    userdatamanager.cpp
    fuzzysearch.h
    fuzzysearch.cpp
    keyboardlayout.h
    keyboardlayout.cpp
    activewindowdetector.h
    activewindowdetector.cpp
    globalshortcuts.h
    globalshortcuts.cpp
)

qt_add_qml_module(apppractice
    URI practice
    VERSION 1.0
    QML_FILES
        Main.qml
        keydata.js
        vstestdata.js
        utils/ShortcutView.qml
        utils/CategoryView.qml
        utils/AppsView.qml
        utils/Testground.qml
        utils/Result.qml
        utils/KeyAnalysis.qml
        utils/UserManager.qml
        utils/Settings.qml
        utils/LookupView.qml
        utils/CircularProgress.qml
        utils/ProgressDashboard.qml
    RESOURCES
        Resource.qrc
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

# Link X11 library for Linux active window detection
if(UNIX AND NOT APPLE AND X11_FOUND)
    target_link_libraries(apppractice PRIVATE ${X11_LIBRARIES})
    target_include_directories(apppractice PRIVATE ${X11_INCLUDE_DIR})
endif()

include(GNUInstallDirs)
install(TARGETS apppractice
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
