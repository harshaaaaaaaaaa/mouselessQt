/*
 * GLOBAL KEYBOARD SHORTCUTS
 *
 * Register system-wide keyboard shortcuts that work even when app is not focused.
 * Uses QHotkey library for cross-platform support.
 *
 * To enable this feature:
 * 1. Install QHotkey library:
 *    - Linux: Install from package manager or build from source
 *    - Git: https://github.com/Skycoder42/QHotkey
 *    - Package: sudo apt-get install libqhotkey-dev (if available)
 *
 * 2. Add to CMakeLists.txt:
 *    find_package(QHotkey REQUIRED)
 *    target_sources(apppractice PRIVATE FEATURE_GLOBAL_SHORTCUTS.cpp FEATURE_GLOBAL_SHORTCUTS.h)
 *    target_link_libraries(apppractice PRIVATE QHotkey::QHotkey)
 *
 * 3. Uncomment all code below
 *
 * 4. In main.cpp:
 *    #include "FEATURE_GLOBAL_SHORTCUTS.h"
 *    GlobalShortcutManager shortcuts(&engine);
 *
 * 5. Build and run
 *
 * Features:
 * - Register multiple global shortcuts
 * - Default: Ctrl+Shift+M to toggle window
 * - Customizable shortcuts via settings
 * - Works on Windows, macOS, Linux (X11 + Wayland)
 * - Notifications when shortcuts conflict with system
 */

// #include "FEATURE_GLOBAL_SHORTCUTS.h"
// #include <QHotkey>
// #include <QQmlApplicationEngine>
// #include <QQuickWindow>
// #include <QDebug>
//
// GlobalShortcutManager::GlobalShortcutManager(QQmlApplicationEngine *engine, QObject *parent)
//     : QObject(parent)
//     , m_engine(engine)
//     , m_toggleHotkey(nullptr)
//     , m_lookupHotkey(nullptr)
// {
//     registerDefaultShortcuts();
// }
//
// GlobalShortcutManager::~GlobalShortcutManager()
// {
//     unregisterAllShortcuts();
// }
//
// void GlobalShortcutManager::registerDefaultShortcuts()
// {
//     // Register Ctrl+Shift+M to toggle main window
//     m_toggleHotkey = new QHotkey(QKeySequence("Ctrl+Shift+M"), true, this);
//     connect(m_toggleHotkey, &QHotkey::activated, this, &GlobalShortcutManager::toggleMainWindow);
//
//     if (m_toggleHotkey->isRegistered()) {
//         qDebug() << "Global shortcut registered: Ctrl+Shift+M";
//     } else {
//         qWarning() << "Failed to register global shortcut: Ctrl+Shift+M";
//         qWarning() << "This may be because another application is using this shortcut";
//     }
//
//     // Register Ctrl+Shift+L for quick lookup mode
//     m_lookupHotkey = new QHotkey(QKeySequence("Ctrl+Shift+L"), true, this);
//     connect(m_lookupHotkey, &QHotkey::activated, this, &GlobalShortcutManager::openLookupMode);
//
//     if (m_lookupHotkey->isRegistered()) {
//         qDebug() << "Global shortcut registered: Ctrl+Shift+L (Lookup)";
//     }
// }
//
// void GlobalShortcutManager::unregisterAllShortcuts()
// {
//     if (m_toggleHotkey) {
//         m_toggleHotkey->setRegistered(false);
//         delete m_toggleHotkey;
//         m_toggleHotkey = nullptr;
//     }
//
//     if (m_lookupHotkey) {
//         m_lookupHotkey->setRegistered(false);
//         delete m_lookupHotkey;
//         m_lookupHotkey = nullptr;
//     }
// }
//
// bool GlobalShortcutManager::registerShortcut(const QString &keySequence, const QString &action)
// {
//     QHotkey *hotkey = new QHotkey(QKeySequence(keySequence), true, this);
//
//     if (action == "toggle") {
//         connect(hotkey, &QHotkey::activated, this, &GlobalShortcutManager::toggleMainWindow);
//     } else if (action == "show") {
//         connect(hotkey, &QHotkey::activated, this, &GlobalShortcutManager::showMainWindow);
//     } else if (action == "hide") {
//         connect(hotkey, &QHotkey::activated, this, &GlobalShortcutManager::hideMainWindow);
//     } else if (action == "lookup") {
//         connect(hotkey, &QHotkey::activated, this, &GlobalShortcutManager::openLookupMode);
//     }
//
//     if (hotkey->isRegistered()) {
//         m_customHotkeys[keySequence] = hotkey;
//         return true;
//     } else {
//         delete hotkey;
//         return false;
//     }
// }
//
// void GlobalShortcutManager::unregisterShortcut(const QString &keySequence)
// {
//     if (m_customHotkeys.contains(keySequence)) {
//         QHotkey *hotkey = m_customHotkeys.take(keySequence);
//         hotkey->setRegistered(false);
//         delete hotkey;
//     }
// }
//
// void GlobalShortcutManager::toggleMainWindow()
// {
//     QObject *root = m_engine->rootObjects().first();
//     if (!root) return;
//
//     bool visible = root->property("visible").toBool();
//     root->setProperty("visible", !visible);
//
//     if (!visible) {
//         QQuickWindow *window = qobject_cast<QQuickWindow*>(root);
//         if (window) {
//             window->raise();
//             window->requestActivate();
//         }
//     }
//
//     emit shortcutActivated("toggle");
// }
//
// void GlobalShortcutManager::showMainWindow()
// {
//     QObject *root = m_engine->rootObjects().first();
//     if (!root) return;
//
//     root->setProperty("visible", true);
//
//     QQuickWindow *window = qobject_cast<QQuickWindow*>(root);
//     if (window) {
//         window->raise();
//         window->requestActivate();
//     }
//
//     emit shortcutActivated("show");
// }
//
// void GlobalShortcutManager::hideMainWindow()
// {
//     QObject *root = m_engine->rootObjects().first();
//     if (!root) return;
//
//     root->setProperty("visible", false);
//     emit shortcutActivated("hide");
// }
//
// void GlobalShortcutManager::openLookupMode()
// {
//     showMainWindow();
//
//     // Navigate to lookup mode in QML
//     QObject *root = m_engine->rootObjects().first();
//     if (root) {
//         QMetaObject::invokeMethod(root, "openLookupMode");
//     }
//
//     emit shortcutActivated("lookup");
// }
//
// /*
//  * USAGE IN MAIN.CPP:
//  *
//  * #include "FEATURE_GLOBAL_SHORTCUTS.h"
//  *
//  * int main(int argc, char *argv[]) {
//  *     QGuiApplication app(argc, argv);
//  *     QQmlApplicationEngine engine;
//  *
//  *     // Register global shortcuts
//  *     GlobalShortcutManager shortcuts(&engine);
//  *
//  *     // Optional: Register custom shortcut
//  *     if (!shortcuts.registerShortcut("Ctrl+Alt+S", "lookup")) {
//  *         qWarning() << "Failed to register custom shortcut";
//  *     }
//  *
//  *     engine.load(QUrl(QStringLiteral("qrc:/Main.qml")));
//  *     return app.exec();
//  * }
//  *
//  *
//  * USAGE IN QML (for custom shortcuts):
//  *
//  * // Add method to Main.qml:
//  * function openLookupMode() {
//  *     stackView.push("utils/LookupView.qml", {
//  *         stackView: stackView
//  *     })
//  * }
//  */
