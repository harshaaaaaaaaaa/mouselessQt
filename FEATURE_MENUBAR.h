/*
 * MENU BAR / SYSTEM TRAY INTEGRATION - HEADER
 *
 * To enable this feature, uncomment all code and follow instructions in FEATURE_MENUBAR.cpp
 */

// #ifndef FEATURE_MENUBAR_H
// #define FEATURE_MENUBAR_H
//
// #include <QObject>
// #include <QSystemTrayIcon>
// #include <QMenu>
// #include <QQmlApplicationEngine>
//
// class MenuBarManager : public QObject
// {
//     Q_OBJECT
//
// public:
//     explicit MenuBarManager(QQmlApplicationEngine *engine, QObject *parent = nullptr);
//     ~MenuBarManager();
//
// public slots:
//     void showMainWindow();
//     void hideMainWindow();
//     void toggleMainWindow();
//     void openSettings();
//
// private:
//     void setupSystemTray();
//     void registerGlobalShortcut();
//     void unregisterGlobalShortcut();
//
//     QQmlApplicationEngine *m_engine;
//     QSystemTrayIcon *m_trayIcon;
//     QMenu *m_trayMenu;
//     bool m_globalShortcutEnabled;
// };
//
// #endif // FEATURE_MENUBAR_H
