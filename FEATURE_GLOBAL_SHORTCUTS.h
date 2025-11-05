/*
 * GLOBAL KEYBOARD SHORTCUTS - HEADER
 *
 * To enable, uncomment and follow instructions in FEATURE_GLOBAL_SHORTCUTS.cpp
 * Requires QHotkey library: https://github.com/Skycoder42/QHotkey
 */

// #ifndef FEATURE_GLOBAL_SHORTCUTS_H
// #define FEATURE_GLOBAL_SHORTCUTS_H
//
// #include <QObject>
// #include <QString>
// #include <QMap>
// #include <QQmlApplicationEngine>
//
// class QHotkey;
//
// class GlobalShortcutManager : public QObject
// {
//     Q_OBJECT
//
// public:
//     explicit GlobalShortcutManager(QQmlApplicationEngine *engine, QObject *parent = nullptr);
//     ~GlobalShortcutManager();
//
//     // Register custom shortcuts
//     bool registerShortcut(const QString &keySequence, const QString &action);
//     void unregisterShortcut(const QString &keySequence);
//
// signals:
//     void shortcutActivated(const QString &action);
//
// private slots:
//     void toggleMainWindow();
//     void showMainWindow();
//     void hideMainWindow();
//     void openLookupMode();
//
// private:
//     void registerDefaultShortcuts();
//     void unregisterAllShortcuts();
//
//     QQmlApplicationEngine *m_engine;
//     QHotkey *m_toggleHotkey;
//     QHotkey *m_lookupHotkey;
//     QMap<QString, QHotkey*> m_customHotkeys;
// };
//
// #endif // FEATURE_GLOBAL_SHORTCUTS_H
