#include "keyboardlayout.h"
#include <QDebug>
#include <QProcess>
#include <QLocale>

KeyboardLayout::KeyboardLayout(QObject *parent)
    : QObject(parent)
    , m_currentLayout("QWERTY")
{
    initializeLayoutMaps();
    detectLayout();
}

QString KeyboardLayout::currentLayout() const
{
    return m_currentLayout;
}

QVariantMap KeyboardLayout::supportedLayouts() const
{
    QVariantMap layouts;
    layouts["QWERTY"] = "QWERTY (English, US)";
    layouts["AZERTY"] = "AZERTY (French, Belgian)";
    layouts["QWERTZ"] = "QWERTZ (German, Swiss)";
    return layouts;
}

void KeyboardLayout::detectLayout()
{
    QString detected = detectSystemLayout();
    if (!detected.isEmpty() && detected != m_currentLayout) {
        m_currentLayout = detected;
        emit currentLayoutChanged();
        emit layoutDetected(detected);
        qDebug() << "Keyboard layout detected:" << detected;
    }
}

void KeyboardLayout::setLayout(const QString &layoutName)
{
    if (isLayoutSupported(layoutName) && layoutName != m_currentLayout) {
        m_currentLayout = layoutName;
        emit currentLayoutChanged();
        qDebug() << "Keyboard layout set to:" << layoutName;
    }
}

QString KeyboardLayout::mapKey(const QString &key, const QString &fromLayout, const QString &toLayout)
{
    if (fromLayout == toLayout || !isLayoutSupported(fromLayout) || !isLayoutSupported(toLayout)) {
        return key;
    }

    QString normalizedKey = normalizeKey(key);

    // Map from source layout to QWERTY first
    QString qwertyKey = normalizedKey;
    if (fromLayout != "QWERTY" && m_layoutMaps.contains(fromLayout)) {
        const QMap<QString, QString> &fromMap = m_layoutMaps[fromLayout];
        // Reverse lookup: find QWERTY key for this layout's key
        for (auto it = fromMap.begin(); it != fromMap.end(); ++it) {
            if (it.value().toLower() == normalizedKey.toLower()) {
                qwertyKey = it.key();
                break;
            }
        }
    }

    // Map from QWERTY to target layout
    if (toLayout != "QWERTY" && m_layoutMaps.contains(toLayout)) {
        const QMap<QString, QString> &toMap = m_layoutMaps[toLayout];
        if (toMap.contains(qwertyKey)) {
            return toMap[qwertyKey];
        }
    }

    return normalizedKey;
}

QString KeyboardLayout::mapKeyToCurrentLayout(const QString &key, const QString &fromLayout)
{
    return mapKey(key, fromLayout, m_currentLayout);
}

QVariantList KeyboardLayout::mapKeys(const QVariantList &keys, const QString &fromLayout)
{
    QVariantList mappedKeys;
    for (const QVariant &key : keys) {
        mappedKeys.append(mapKeyToCurrentLayout(key.toString(), fromLayout));
    }
    return mappedKeys;
}

bool KeyboardLayout::isLayoutSupported(const QString &layoutName)
{
    return layoutName == "QWERTY" || layoutName == "AZERTY" || layoutName == "QWERTZ";
}

QStringList KeyboardLayout::getLayoutDifferences(const QString &layout1, const QString &layout2)
{
    QStringList differences;

    if (!isLayoutSupported(layout1) || !isLayoutSupported(layout2)) {
        return differences;
    }

    if (layout1 == layout2) {
        return differences;
    }

    // Get keys that are different between layouts
    const QMap<QString, QString> &map1 = m_layoutMaps[layout1];
    const QMap<QString, QString> &map2 = m_layoutMaps[layout2];

    for (auto it = map1.begin(); it != map1.end(); ++it) {
        QString key = it.key();
        QString val1 = it.value();
        QString val2 = map2.value(key, key);

        if (val1 != val2) {
            differences.append(QString("%1: %2 → %3").arg(key, val1, val2));
        }
    }

    return differences;
}

void KeyboardLayout::initializeLayoutMaps()
{
    // AZERTY layout mapping (from QWERTY to AZERTY)
    QMap<QString, QString> azertyMap;
    // Top row number keys
    azertyMap["1"] = "&";
    azertyMap["2"] = "é";
    azertyMap["3"] = "\"";
    azertyMap["4"] = "'";
    azertyMap["5"] = "(";
    azertyMap["6"] = "-";
    azertyMap["7"] = "è";
    azertyMap["8"] = "_";
    azertyMap["9"] = "ç";
    azertyMap["0"] = "à";

    // Letter keys (different positions)
    azertyMap["q"] = "a";
    azertyMap["w"] = "z";
    azertyMap["a"] = "q";
    azertyMap["z"] = "w";
    azertyMap["m"] = ",";
    azertyMap[";"] = "m";
    azertyMap[","] = ";";

    // Special characters
    azertyMap["-"] = ")";
    azertyMap["="] = "=";
    azertyMap["["] = "^";
    azertyMap["]"] = "$";

    m_layoutMaps["AZERTY"] = azertyMap;

    // QWERTZ layout mapping (from QWERTY to QWERTZ)
    QMap<QString, QString> qwertzMap;
    // Letter keys
    qwertzMap["y"] = "z";
    qwertzMap["z"] = "y";

    // Special characters
    qwertzMap["-"] = "ß";
    qwertzMap["["] = "ü";
    qwertzMap["]"] = "+";
    qwertzMap[";"] = "ö";
    qwertzMap["'"] = "ä";
    qwertzMap["/"] = "-";

    m_layoutMaps["QWERTZ"] = qwertzMap;

    // QWERTY is the base layout (identity mapping)
    QMap<QString, QString> qwertyMap;
    m_layoutMaps["QWERTY"] = qwertyMap;
}

QString KeyboardLayout::detectSystemLayout()
{
    // Try to detect layout from system
    QString layout = "QWERTY"; // Default

#ifdef Q_OS_LINUX
    // Try to detect from X11 or Wayland
    QProcess process;
    process.start("setxkbmap", QStringList() << "-query");
    if (process.waitForFinished(1000)) {
        QString output = process.readAllStandardOutput();
        if (output.contains("azerty", Qt::CaseInsensitive)) {
            layout = "AZERTY";
        } else if (output.contains("qwertz", Qt::CaseInsensitive) ||
                   output.contains("de", Qt::CaseInsensitive) ||
                   output.contains("ch", Qt::CaseInsensitive)) {
            layout = "QWERTZ";
        }
    }
#elif defined(Q_OS_WIN)
    // Windows keyboard layout detection
    // Can use GetKeyboardLayout() Win32 API
    // For now, use locale-based detection
    QLocale locale = QLocale::system();
    QString localeName = locale.name();

    if (localeName.startsWith("fr") || localeName.startsWith("be")) {
        layout = "AZERTY";
    } else if (localeName.startsWith("de") || localeName.startsWith("at") ||
               localeName.startsWith("ch")) {
        layout = "QWERTZ";
    }
#elif defined(Q_OS_MACOS)
    // macOS keyboard layout detection
    // Can use TISCopyCurrentKeyboardInputSource() API
    // For now, use locale-based detection
    QLocale locale = QLocale::system();
    QString localeName = locale.name();

    if (localeName.startsWith("fr") || localeName.startsWith("be")) {
        layout = "AZERTY";
    } else if (localeName.startsWith("de") || localeName.startsWith("at") ||
               localeName.startsWith("ch")) {
        layout = "QWERTZ";
    }
#endif

    return layout;
}

QString KeyboardLayout::normalizeKey(const QString &key)
{
    // Normalize key representation (lowercase, trim)
    QString normalized = key.trimmed().toLower();

    // Handle special cases
    if (normalized == "ctrl" || normalized == "control") {
        return "ctrl";
    } else if (normalized == "alt" || normalized == "option") {
        return "alt";
    } else if (normalized == "shift") {
        return "shift";
    } else if (normalized == "meta" || normalized == "cmd" || normalized == "win" || normalized == "super") {
        return "meta";
    }

    return normalized;
}
