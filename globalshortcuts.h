#ifndef GLOBALSHORTCUTS_H
#define GLOBALSHORTCUTS_H

#include <QObject>
#include <QHash>
#include <QKeySequence>
#include <QAbstractNativeEventFilter>

class GlobalShortcuts : public QObject, public QAbstractNativeEventFilter
{
    Q_OBJECT
    Q_PROPERTY(bool enabled READ enabled WRITE setEnabled NOTIFY enabledChanged)

public:
    explicit GlobalShortcuts(QObject *parent = nullptr);
    ~GlobalShortcuts();

    bool enabled() const { return m_enabled; }
    void setEnabled(bool enabled);

    // Register shortcuts
    Q_INVOKABLE bool registerShortcut(const QString &id, const QString &keys);
    Q_INVOKABLE void unregisterShortcut(const QString &id);
    Q_INVOKABLE void unregisterAll();

    // Native event filter
    bool nativeEventFilter(const QByteArray &eventType, void *message, qintptr *result) override;

signals:
    void shortcutActivated(const QString &id);
    void enabledChanged();

private:
    struct ShortcutData {
        QString id;
        Qt::Key key;
        Qt::KeyboardModifiers modifiers;
#ifdef Q_OS_LINUX
        unsigned int nativeKey;
        unsigned int nativeModifiers;
#endif
    };

    bool registerNativeShortcut(const ShortcutData &shortcut);
    void unregisterNativeShortcut(const ShortcutData &shortcut);

#ifdef Q_OS_LINUX
    unsigned int nativeKeycode(Qt::Key key);
    unsigned int nativeModifiers(Qt::KeyboardModifiers modifiers);
    void grabKey(unsigned int keycode, unsigned int modifiers);
    void ungrabKey(unsigned int keycode, unsigned int modifiers);
    void *m_display;  // Display* stored as void* to avoid X11 headers in header file
#endif

    bool m_enabled;
    QHash<QString, ShortcutData> m_shortcuts;
};

#endif // GLOBALSHORTCUTS_H
