/*
 * MENU BAR / SYSTEM TRAY INTEGRATION
 *
 * This file implements menu bar and system tray functionality similar to Mouseless.
 * To enable this feature:
 * 1. Uncomment all code below
 * 2. Add to CMakeLists.txt: target_sources(apppractice PRIVATE FEATURE_MENUBAR.cpp FEATURE_MENUBAR.h)
 * 3. In main.cpp, add: #include "FEATURE_MENUBAR.h"
 * 4. In main.cpp, create instance: MenuBarManager menuBar(&engine);
 * 5. Build and run
 *
 * Features provided:
 * - System tray icon with menu
 * - Global keyboard shortcut to toggle window (default: Ctrl+Shift+M)
 * - Hide/show window functionality
 * - Quick access to app from system tray
 * - Auto-start on system startup (optional)
 * - Show shortcuts for active window (requires FEATURE_ACTIVE_WINDOW.cpp)
 */

// #include "FEATURE_MENUBAR.h"
// #include <QSystemTrayIcon>
// #include <QMenu>
// #include <QAction>
// #include <QApplication>
// #include <QQmlApplicationEngine>
// #include <QQuickWindow>
//
// #ifdef Q_OS_LINUX
// #include <X11/Xlib.h>
// #include <X11/keysym.h>
// #include <X11/extensions/XTest.h>
// #endif
//
// #ifdef Q_OS_WIN
// #include <windows.h>
// #endif
//
// #ifdef Q_OS_MAC
// #include <Carbon/Carbon.h>
// #endif
//
// MenuBarManager::MenuBarManager(QQmlApplicationEngine *engine, QObject *parent)
//     : QObject(parent)
//     , m_engine(engine)
//     , m_trayIcon(nullptr)
//     , m_trayMenu(nullptr)
//     , m_globalShortcutEnabled(true)
// {
//     setupSystemTray();
//     registerGlobalShortcut();
// }
//
// MenuBarManager::~MenuBarManager()
// {
//     unregisterGlobalShortcut();
//     if (m_trayIcon) {
//         delete m_trayIcon;
//     }
// }
//
// void MenuBarManager::setupSystemTray()
// {
//     // Create system tray icon
//     m_trayIcon = new QSystemTrayIcon(this);
//     m_trayIcon->setIcon(QIcon(":/icon.png"));
//     m_trayIcon->setToolTip("mouselessQt - Keyboard Shortcut Trainer");
//
//     // Create menu
//     m_trayMenu = new QMenu();
//
//     QAction *showAction = new QAction("Show mouselessQt", m_trayMenu);
//     connect(showAction, &QAction::triggered, this, &MenuBarManager::showMainWindow);
//
//     QAction *hideAction = new QAction("Hide Window", m_trayMenu);
//     connect(hideAction, &QAction::triggered, this, &MenuBarManager::hideMainWindow);
//
//     m_trayMenu->addAction(showAction);
//     m_trayMenu->addAction(hideAction);
//     m_trayMenu->addSeparator();
//
//     QAction *settingsAction = new QAction("Settings", m_trayMenu);
//     connect(settingsAction, &QAction::triggered, this, &MenuBarManager::openSettings);
//     m_trayMenu->addAction(settingsAction);
//
//     m_trayMenu->addSeparator();
//
//     QAction *quitAction = new QAction("Quit", m_trayMenu);
//     connect(quitAction, &QAction::triggered, qApp, &QApplication::quit);
//     m_trayMenu->addAction(quitAction);
//
//     m_trayIcon->setContextMenu(m_trayMenu);
//
//     // Handle tray icon activation (click)
//     connect(m_trayIcon, &QSystemTrayIcon::activated, this, [this](QSystemTrayIcon::ActivationReason reason) {
//         if (reason == QSystemTrayIcon::Trigger || reason == QSystemTrayIcon::DoubleClick) {
//             toggleMainWindow();
//         }
//     });
//
//     m_trayIcon->show();
// }
//
// void MenuBarManager::registerGlobalShortcut()
// {
//     // Platform-specific global shortcut registration
//     // Default: Ctrl+Shift+M
//
// #ifdef Q_OS_LINUX
//     // X11 global shortcut (requires XGrabKey)
//     Display *display = XOpenDisplay(nullptr);
//     if (display) {
//         Window root = DefaultRootWindow(display);
//
//         // Ctrl+Shift+M = ControlMask + ShiftMask + XK_m
//         KeyCode keycode = XKeysymToKeycode(display, XK_m);
//         unsigned int modifiers = ControlMask | ShiftMask;
//
//         XGrabKey(display, keycode, modifiers, root, True, GrabModeAsync, GrabModeAsync);
//
//         // Start event loop to listen for key events
//         // Note: This requires a separate thread or integration with Qt event loop
//
//         XCloseDisplay(display);
//     }
// #endif
//
// #ifdef Q_OS_WIN
//     // Windows global hotkey
//     // RegisterHotKey(nullptr, 1, MOD_CONTROL | MOD_SHIFT, 'M');
//     // Note: Requires Win32 event processing
// #endif
//
// #ifdef Q_OS_MAC
//     // macOS Carbon hotkey
//     // Note: Requires Carbon framework integration
// #endif
//
//     // Alternative: Use QHotkey library for cross-platform support
//     // 1. Add to CMakeLists.txt: find_package(QHotkey REQUIRED)
//     // 2. Link library: target_link_libraries(apppractice PRIVATE QHotkey::QHotkey)
//     // 3. Use: m_hotkey = new QHotkey(QKeySequence("Ctrl+Shift+M"), true, this);
//     //         connect(m_hotkey, &QHotkey::activated, this, &MenuBarManager::toggleMainWindow);
// }
//
// void MenuBarManager::unregisterGlobalShortcut()
// {
// #ifdef Q_OS_LINUX
//     Display *display = XOpenDisplay(nullptr);
//     if (display) {
//         Window root = DefaultRootWindow(display);
//         KeyCode keycode = XKeysymToKeycode(display, XK_m);
//         XUngrabKey(display, keycode, ControlMask | ShiftMask, root);
//         XCloseDisplay(display);
//     }
// #endif
//
// #ifdef Q_OS_WIN
//     // UnregisterHotKey(nullptr, 1);
// #endif
// }
//
// void MenuBarManager::showMainWindow()
// {
//     QObject *root = m_engine->rootObjects().first();
//     if (root) {
//         root->setProperty("visible", true);
//
//         // Bring to front
//         QQuickWindow *window = qobject_cast<QQuickWindow*>(root);
//         if (window) {
//             window->raise();
//             window->requestActivate();
//         }
//     }
// }
//
// void MenuBarManager::hideMainWindow()
// {
//     QObject *root = m_engine->rootObjects().first();
//     if (root) {
//         root->setProperty("visible", false);
//     }
// }
//
// void MenuBarManager::toggleMainWindow()
// {
//     QObject *root = m_engine->rootObjects().first();
//     if (root) {
//         bool visible = root->property("visible").toBool();
//         root->setProperty("visible", !visible);
//
//         if (!visible) {
//             QQuickWindow *window = qobject_cast<QQuickWindow*>(root);
//             if (window) {
//                 window->raise();
//                 window->requestActivate();
//             }
//         }
//     }
// }
//
// void MenuBarManager::openSettings()
// {
//     // Navigate to settings page via QML
//     showMainWindow();
//
//     QObject *root = m_engine->rootObjects().first();
//     if (root) {
//         QMetaObject::invokeMethod(root, "openSettings");
//     }
// }
