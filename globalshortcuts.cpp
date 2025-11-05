#include "globalshortcuts.h"
#include <QDebug>
#include <QGuiApplication>

#ifdef Q_OS_LINUX
#include <QX11Info>
#include <xcb/xcb.h>
#endif

GlobalShortcuts::GlobalShortcuts(QObject *parent)
    : QObject(parent)
    , m_enabled(true)
#ifdef Q_OS_LINUX
    , m_display(nullptr)
#endif
{
#ifdef Q_OS_LINUX
    m_display = XOpenDisplay(nullptr);
    if (!m_display) {
        qWarning() << "Failed to open X11 display for global shortcuts";
        m_enabled = false;
    }
#endif

    if (m_enabled) {
        qApp->installNativeEventFilter(this);

        // Register default shortcuts
        registerShortcut("toggle", "Ctrl+Shift+M");
        registerShortcut("lookup", "Ctrl+Shift+L");
    }
}

GlobalShortcuts::~GlobalShortcuts()
{
    unregisterAll();

#ifdef Q_OS_LINUX
    if (m_display) {
        XCloseDisplay(m_display);
    }
#endif
}

void GlobalShortcuts::setEnabled(bool enabled)
{
    if (m_enabled == enabled)
        return;

    m_enabled = enabled;

    if (m_enabled) {
        // Re-register all shortcuts
        for (const auto &shortcut : m_shortcuts) {
            registerNativeShortcut(shortcut);
        }
    } else {
        // Unregister all shortcuts
        for (const auto &shortcut : m_shortcuts) {
            unregisterNativeShortcut(shortcut);
        }
    }

    emit enabledChanged();
}

bool GlobalShortcuts::registerShortcut(const QString &id, const QString &keys)
{
    QKeySequence sequence(keys);
    if (sequence.isEmpty()) {
        qWarning() << "Invalid key sequence:" << keys;
        return false;
    }

    // Parse the key sequence
    int combined = sequence[0];
    Qt::KeyboardModifiers modifiers = Qt::NoModifier;
    Qt::Key key = Qt::Key_unknown;

    // Extract modifiers
    if (combined & Qt::ShiftModifier) modifiers |= Qt::ShiftModifier;
    if (combined & Qt::ControlModifier) modifiers |= Qt::ControlModifier;
    if (combined & Qt::AltModifier) modifiers |= Qt::AltModifier;
    if (combined & Qt::MetaModifier) modifiers |= Qt::MetaModifier;

    // Extract key
    key = static_cast<Qt::Key>(combined & ~Qt::KeyboardModifierMask);

    ShortcutData shortcut;
    shortcut.id = id;
    shortcut.key = key;
    shortcut.modifiers = modifiers;

#ifdef Q_OS_LINUX
    if (m_display) {
        shortcut.nativeKey = nativeKeycode(key);
        shortcut.nativeModifiers = nativeModifiers(modifiers);
    }
#endif

    // Unregister existing if present
    if (m_shortcuts.contains(id)) {
        unregisterShortcut(id);
    }

    m_shortcuts[id] = shortcut;

    if (m_enabled) {
        return registerNativeShortcut(shortcut);
    }

    return true;
}

void GlobalShortcuts::unregisterShortcut(const QString &id)
{
    if (!m_shortcuts.contains(id))
        return;

    if (m_enabled) {
        unregisterNativeShortcut(m_shortcuts[id]);
    }

    m_shortcuts.remove(id);
}

void GlobalShortcuts::unregisterAll()
{
    if (m_enabled) {
        for (const auto &shortcut : m_shortcuts) {
            unregisterNativeShortcut(shortcut);
        }
    }
    m_shortcuts.clear();
}

bool GlobalShortcuts::nativeEventFilter(const QByteArray &eventType, void *message, qintptr *result)
{
    Q_UNUSED(result)

#ifdef Q_OS_LINUX
    if (eventType == "xcb_generic_event_t") {
        xcb_generic_event_t *ev = static_cast<xcb_generic_event_t *>(message);

        if ((ev->response_type & ~0x80) == XCB_KEY_PRESS) {
            xcb_key_press_event_t *keyEvent = static_cast<xcb_key_press_event_t *>(message);

            // Check which shortcut was activated
            for (const auto &shortcut : m_shortcuts) {
                if (keyEvent->detail == shortcut.nativeKey &&
                    (keyEvent->state & 0x7F) == shortcut.nativeModifiers) {
                    emit shortcutActivated(shortcut.id);
                    return true;
                }
            }
        }
    }
#endif

    return false;
}

bool GlobalShortcuts::registerNativeShortcut(const ShortcutData &shortcut)
{
#ifdef Q_OS_LINUX
    if (!m_display) return false;

    grabKey(shortcut.nativeKey, shortcut.nativeModifiers);

    qDebug() << "Registered global shortcut:" << shortcut.id;
    return true;
#else
    qWarning() << "Global shortcuts not implemented for this platform";
    return false;
#endif
}

void GlobalShortcuts::unregisterNativeShortcut(const ShortcutData &shortcut)
{
#ifdef Q_OS_LINUX
    if (!m_display) return;

    ungrabKey(shortcut.nativeKey, shortcut.nativeModifiers);

    qDebug() << "Unregistered global shortcut:" << shortcut.id;
#endif
}

#ifdef Q_OS_LINUX
unsigned int GlobalShortcuts::nativeKeycode(Qt::Key key)
{
    KeySym keysym = NoSymbol;

    // Map Qt keys to X11 KeySyms
    switch (key) {
    case Qt::Key_A: keysym = XK_a; break;
    case Qt::Key_B: keysym = XK_b; break;
    case Qt::Key_C: keysym = XK_c; break;
    case Qt::Key_D: keysym = XK_d; break;
    case Qt::Key_E: keysym = XK_e; break;
    case Qt::Key_F: keysym = XK_f; break;
    case Qt::Key_G: keysym = XK_g; break;
    case Qt::Key_H: keysym = XK_h; break;
    case Qt::Key_I: keysym = XK_i; break;
    case Qt::Key_J: keysym = XK_j; break;
    case Qt::Key_K: keysym = XK_k; break;
    case Qt::Key_L: keysym = XK_l; break;
    case Qt::Key_M: keysym = XK_m; break;
    case Qt::Key_N: keysym = XK_n; break;
    case Qt::Key_O: keysym = XK_o; break;
    case Qt::Key_P: keysym = XK_p; break;
    case Qt::Key_Q: keysym = XK_q; break;
    case Qt::Key_R: keysym = XK_r; break;
    case Qt::Key_S: keysym = XK_s; break;
    case Qt::Key_T: keysym = XK_t; break;
    case Qt::Key_U: keysym = XK_u; break;
    case Qt::Key_V: keysym = XK_v; break;
    case Qt::Key_W: keysym = XK_w; break;
    case Qt::Key_X: keysym = XK_x; break;
    case Qt::Key_Y: keysym = XK_y; break;
    case Qt::Key_Z: keysym = XK_z; break;
    case Qt::Key_F1: keysym = XK_F1; break;
    case Qt::Key_F2: keysym = XK_F2; break;
    case Qt::Key_F3: keysym = XK_F3; break;
    case Qt::Key_F4: keysym = XK_F4; break;
    case Qt::Key_F5: keysym = XK_F5; break;
    case Qt::Key_F6: keysym = XK_F6; break;
    case Qt::Key_F7: keysym = XK_F7; break;
    case Qt::Key_F8: keysym = XK_F8; break;
    case Qt::Key_F9: keysym = XK_F9; break;
    case Qt::Key_F10: keysym = XK_F10; break;
    case Qt::Key_F11: keysym = XK_F11; break;
    case Qt::Key_F12: keysym = XK_F12; break;
    case Qt::Key_Space: keysym = XK_space; break;
    case Qt::Key_Return: keysym = XK_Return; break;
    case Qt::Key_Escape: keysym = XK_Escape; break;
    default:
        keysym = static_cast<KeySym>(key);
        break;
    }

    return XKeysymToKeycode(m_display, keysym);
}

unsigned int GlobalShortcuts::nativeModifiers(Qt::KeyboardModifiers modifiers)
{
    unsigned int native = 0;

    if (modifiers & Qt::ShiftModifier)
        native |= ShiftMask;
    if (modifiers & Qt::ControlModifier)
        native |= ControlMask;
    if (modifiers & Qt::AltModifier)
        native |= Mod1Mask;
    if (modifiers & Qt::MetaModifier)
        native |= Mod4Mask;

    return native;
}

void GlobalShortcuts::grabKey(unsigned int keycode, unsigned int modifiers)
{
    Window root = DefaultRootWindow(m_display);

    // Grab with NumLock, CapsLock, and ScrollLock in various states
    XGrabKey(m_display, keycode, modifiers, root, True, GrabModeAsync, GrabModeAsync);
    XGrabKey(m_display, keycode, modifiers | Mod2Mask, root, True, GrabModeAsync, GrabModeAsync);
    XGrabKey(m_display, keycode, modifiers | LockMask, root, True, GrabModeAsync, GrabModeAsync);
    XGrabKey(m_display, keycode, modifiers | Mod2Mask | LockMask, root, True, GrabModeAsync, GrabModeAsync);

    XSync(m_display, False);
}

void GlobalShortcuts::ungrabKey(unsigned int keycode, unsigned int modifiers)
{
    Window root = DefaultRootWindow(m_display);

    XUngrabKey(m_display, keycode, modifiers, root);
    XUngrabKey(m_display, keycode, modifiers | Mod2Mask, root);
    XUngrabKey(m_display, keycode, modifiers | LockMask, root);
    XUngrabKey(m_display, keycode, modifiers | Mod2Mask | LockMask, root);

    XSync(m_display, False);
}
#endif
