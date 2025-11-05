/*
 * ACTIVE WINDOW DETECTION - HEADER
 *
 * To enable, uncomment and follow instructions in FEATURE_ACTIVE_WINDOW.cpp
 */

// #ifndef FEATURE_ACTIVE_WINDOW_H
// #define FEATURE_ACTIVE_WINDOW_H
//
// #include <QObject>
// #include <QString>
// #include <QJsonObject>
//
// class ActiveWindowDetector : public QObject
// {
//     Q_OBJECT
//     Q_PROPERTY(QString currentApp READ currentApp NOTIFY currentAppChanged)
//     Q_PROPERTY(QString currentClass READ currentClass NOTIFY currentClassChanged)
//     Q_PROPERTY(QString currentTitle READ currentTitle NOTIFY currentTitleChanged)
//     Q_PROPERTY(bool isI3WM READ isI3WM CONSTANT)
//
// public:
//     explicit ActiveWindowDetector(QObject *parent = nullptr);
//
//     QString currentApp() const;
//     QString currentClass() const;
//     QString currentTitle() const;
//     bool isI3WM() const;
//
// signals:
//     void currentAppChanged();
//     void currentClassChanged();
//     void currentTitleChanged();
//     void activeWindowChanged(const QString &app, const QString &wm_class, const QString &title);
//
// private slots:
//     void updateActiveWindow();
//
// private:
//     void detectI3WM();
//     void getActiveFromI3();
//     void getActiveFromX11();
//     void getActiveFromWindows();
//     void getActiveFromMacOS();
//     QJsonObject findFocusedWindow(const QJsonObject &node);
//
//     QString m_currentApp;
//     QString m_currentClass;
//     QString m_currentTitle;
//     bool m_isI3WM;
// };
//
// #endif // FEATURE_ACTIVE_WINDOW_H
