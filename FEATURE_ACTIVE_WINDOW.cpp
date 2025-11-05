/*
 * ACTIVE WINDOW DETECTION
 *
 * Detects the currently focused application window and provides shortcuts for it.
 * Works with X11 (Linux), Wayland (limited), Windows, and macOS.
 *
 * Special support for i3wm window manager on Linux.
 *
 * To enable this feature:
 * 1. Uncomment all code below
 * 2. Add to CMakeLists.txt:
 *    - find_package(X11 REQUIRED)  # For Linux/X11
 *    - target_sources(apppractice PRIVATE FEATURE_ACTIVE_WINDOW.cpp FEATURE_ACTIVE_WINDOW.h)
 *    - target_link_libraries(apppractice PRIVATE X11::X11)  # For Linux
 * 3. In main.cpp:
 *    - #include "FEATURE_ACTIVE_WINDOW.h"
 *    - ActiveWindowDetector detector(&engine);
 *    - qmlRegisterSingletonInstance("App.ActiveWindow", 1, 0, "ActiveWindow", &detector);
 * 4. In QML: import App.ActiveWindow 1.0
 * 5. Use: ActiveWindow.currentApp, ActiveWindow.currentClass
 *
 * Features:
 * - Detects active window on X11, Wayland (i3), Windows, macOS
 * - Returns application class name (e.g., "Code", "Firefox", "Vim")
 * - Auto-updates every 500ms
 * - Emits signal when active window changes
 * - i3wm-specific optimizations (uses i3-msg for better detection)
 *
 * i3wm Benefits:
 * - More reliable window detection via i3's IPC
 * - Access to window titles, classes, and IDs
 * - Can detect tiling position and workspace
 * - Better performance than X11 polling
 */

// #include "FEATURE_ACTIVE_WINDOW.h"
// #include <QProcess>
// #include <QTimer>
// #include <QDebug>
// #include <QJsonDocument>
// #include <QJsonObject>
// #include <QJsonArray>
//
// #ifdef Q_OS_LINUX
// #include <X11/Xlib.h>
// #include <X11/Xatom.h>
// #include <X11/Xutil.h>
// #endif
//
// #ifdef Q_OS_WIN
// #include <windows.h>
// #endif
//
// #ifdef Q_OS_MAC
// #import <AppKit/AppKit.h>
// #endif
//
// ActiveWindowDetector::ActiveWindowDetector(QObject *parent)
//     : QObject(parent)
//     , m_currentApp("")
//     , m_currentClass("")
//     , m_currentTitle("")
//     , m_isI3WM(false)
// {
//     // Detect if running i3wm
//     detectI3WM();
//
//     // Start detection timer
//     QTimer *timer = new QTimer(this);
//     connect(timer, &QTimer::timeout, this, &ActiveWindowDetector::updateActiveWindow);
//     timer->start(500);  // Update every 500ms
//
//     // Initial update
//     updateActiveWindow();
// }
//
// void ActiveWindowDetector::detectI3WM()
// {
// #ifdef Q_OS_LINUX
//     // Check if i3-msg command exists
//     QProcess process;
//     process.start("which", QStringList() << "i3-msg");
//     process.waitForFinished();
//
//     if (process.exitCode() == 0) {
//         // i3-msg found, check if i3 is running
//         QProcess i3Process;
//         i3Process.start("i3-msg", QStringList() << "-t" << "get_version");
//         i3Process.waitForFinished();
//
//         if (i3Process.exitCode() == 0) {
//             m_isI3WM = true;
//             qDebug() << "Detected i3wm window manager";
//         }
//     }
// #endif
// }
//
// void ActiveWindowDetector::updateActiveWindow()
// {
//     QString app, wm_class, title;
//
// #ifdef Q_OS_LINUX
//     if (m_isI3WM) {
//         // Use i3's IPC for better detection
//         getActiveFromI3();
//     } else {
//         // Fall back to X11
//         getActiveFromX11();
//     }
// #endif
//
// #ifdef Q_OS_WIN
//     getActiveFromWindows();
// #endif
//
// #ifdef Q_OS_MAC
//     getActiveFromMacOS();
// #endif
//
//     // Emit signal if changed
//     if (m_currentApp != app || m_currentClass != wm_class || m_currentTitle != title) {
//         m_currentApp = app;
//         m_currentClass = wm_class;
//         m_currentTitle = title;
//
//         emit currentAppChanged();
//         emit currentClassChanged();
//         emit currentTitleChanged();
//         emit activeWindowChanged(m_currentApp, m_currentClass, m_currentTitle);
//     }
// }
//
// void ActiveWindowDetector::getActiveFromI3()
// {
// #ifdef Q_OS_LINUX
//     // Query i3 for focused window
//     QProcess process;
//     process.start("i3-msg", QStringList() << "-t" << "get_tree");
//     process.waitForFinished();
//
//     if (process.exitCode() == 0) {
//         QByteArray output = process.readAllStandardOutput();
//         QJsonDocument doc = QJsonDocument::fromJson(output);
//
//         // Find focused window in tree
//         QJsonObject focused = findFocusedWindow(doc.object());
//
//         if (!focused.isEmpty()) {
//             m_currentClass = focused.value("window_properties").toObject()
//                              .value("class").toString();
//             m_currentTitle = focused.value("name").toString();
//             m_currentApp = m_currentClass;  // Use class as app identifier
//         }
//     }
// #endif
// }
//
// QJsonObject ActiveWindowDetector::findFocusedWindow(const QJsonObject &node)
// {
//     // Recursively search for focused window in i3 tree
//     if (node.value("focused").toBool()) {
//         return node;
//     }
//
//     QJsonArray nodes = node.value("nodes").toArray();
//     for (const QJsonValue &child : nodes) {
//         QJsonObject result = findFocusedWindow(child.toObject());
//         if (!result.isEmpty()) {
//             return result;
//         }
//     }
//
//     QJsonArray floating = node.value("floating_nodes").toArray();
//     for (const QJsonValue &child : floating) {
//         QJsonObject result = findFocusedWindow(child.toObject());
//         if (!result.isEmpty()) {
//             return result;
//         }
//     }
//
//     return QJsonObject();
// }
//
// void ActiveWindowDetector::getActiveFromX11()
// {
// #ifdef Q_OS_LINUX
//     Display *display = XOpenDisplay(nullptr);
//     if (!display) {
//         qWarning() << "Cannot open X11 display";
//         return;
//     }
//
//     // Get active window atom
//     Atom activeWindowAtom = XInternAtom(display, "_NET_ACTIVE_WINDOW", True);
//     if (activeWindowAtom == None) {
//         XCloseDisplay(display);
//         return;
//     }
//
//     Window root = DefaultRootWindow(display);
//     Atom actualType;
//     int actualFormat;
//     unsigned long nitems, bytesAfter;
//     unsigned char *prop = nullptr;
//
//     // Get active window ID
//     if (XGetWindowProperty(display, root, activeWindowAtom, 0, 1, False,
//                            XA_WINDOW, &actualType, &actualFormat, &nitems,
//                            &bytesAfter, &prop) == Success && prop) {
//
//         Window activeWindow = *(Window*)prop;
//         XFree(prop);
//
//         // Get WM_CLASS
//         XClassHint classHint;
//         if (XGetClassHint(display, activeWindow, &classHint)) {
//             m_currentClass = QString::fromUtf8(classHint.res_class);
//             m_currentApp = QString::fromUtf8(classHint.res_name);
//
//             XFree(classHint.res_name);
//             XFree(classHint.res_class);
//         }
//
//         // Get window title (_NET_WM_NAME or WM_NAME)
//         Atom netWmNameAtom = XInternAtom(display, "_NET_WM_NAME", False);
//         if (XGetWindowProperty(display, activeWindow, netWmNameAtom, 0, 1024, False,
//                                AnyPropertyType, &actualType, &actualFormat,
//                                &nitems, &bytesAfter, &prop) == Success && prop) {
//             m_currentTitle = QString::fromUtf8(reinterpret_cast<char*>(prop));
//             XFree(prop);
//         }
//     }
//
//     XCloseDisplay(display);
// #endif
// }
//
// void ActiveWindowDetector::getActiveFromWindows()
// {
// #ifdef Q_OS_WIN
//     HWND hwnd = GetForegroundWindow();
//     if (hwnd) {
//         // Get window title
//         WCHAR title[256];
//         GetWindowTextW(hwnd, title, 256);
//         m_currentTitle = QString::fromWCharArray(title);
//
//         // Get class name
//         WCHAR className[256];
//         GetClassNameW(hwnd, className, 256);
//         m_currentClass = QString::fromWCharArray(className);
//
//         // Get process name (app identifier)
//         DWORD processId;
//         GetWindowThreadProcessId(hwnd, &processId);
//
//         HANDLE hProcess = OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, FALSE, processId);
//         if (hProcess) {
//             WCHAR processName[MAX_PATH];
//             DWORD size = MAX_PATH;
//             if (QueryFullProcessImageNameW(hProcess, 0, processName, &size)) {
//                 QString fullPath = QString::fromWCharArray(processName);
//                 // Extract executable name
//                 m_currentApp = fullPath.split("/").last().split("\\").last();
//                 m_currentApp.replace(".exe", "", Qt::CaseInsensitive);
//             }
//             CloseHandle(hProcess);
//         }
//     }
// #endif
// }
//
// void ActiveWindowDetector::getActiveFromMacOS()
// {
// #ifdef Q_OS_MAC
//     @autoreleasepool {
//         NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
//         NSRunningApplication *app = [workspace frontmostApplication];
//
//         if (app) {
//             m_currentApp = QString::fromNSString([app localizedName]);
//             m_currentClass = QString::fromNSString([app bundleIdentifier]);
//
//             // Get window title (requires accessibility permissions)
//             // Note: This is a simplified version
//             m_currentTitle = m_currentApp;  // macOS doesn't easily provide window titles
//         }
//     }
// #endif
// }
//
// QString ActiveWindowDetector::currentApp() const
// {
//     return m_currentApp;
// }
//
// QString ActiveWindowDetector::currentClass() const
// {
//     return m_currentClass;
// }
//
// QString ActiveWindowDetector::currentTitle() const
// {
//     return m_currentTitle;
// }
//
// bool ActiveWindowDetector::isI3WM() const
// {
//     return m_isI3WM;
// }
//
// /*
//  * USAGE IN QML:
//  *
//  * import App.ActiveWindow 1.0
//  *
//  * Text {
//  *     text: "Active: " + ActiveWindow.currentApp
//  * }
//  *
//  * Connections {
//  *     target: ActiveWindow
//  *     function onActiveWindowChanged(app, wm_class, title) {
//  *         console.log("Active window:", app, wm_class, title)
//  *
//  *         // Show shortcuts for active app
//  *         if (app === "Code") {
//  *             showShortcutsFor("vscode")
//  *         } else if (app === "Firefox") {
//  *             showShortcutsFor("firefox")
//  *         }
//  *     }
//  * }
//  */
