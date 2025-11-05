#ifndef KEYBOARDLAYOUT_H
#define KEYBOARDLAYOUT_H

#include <QObject>
#include <QString>
#include <QMap>
#include <QVariantMap>

class KeyboardLayout : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentLayout READ currentLayout NOTIFY currentLayoutChanged)
    Q_PROPERTY(QVariantMap supportedLayouts READ supportedLayouts CONSTANT)

public:
    explicit KeyboardLayout(QObject *parent = nullptr);

    QString currentLayout() const;
    QVariantMap supportedLayouts() const;

    // Layout detection
    Q_INVOKABLE void detectLayout();
    Q_INVOKABLE void setLayout(const QString &layoutName);

    // Key mapping functions
    Q_INVOKABLE QString mapKey(const QString &key, const QString &fromLayout, const QString &toLayout);
    Q_INVOKABLE QString mapKeyToCurrentLayout(const QString &key, const QString &fromLayout = "QWERTY");
    Q_INVOKABLE QVariantList mapKeys(const QVariantList &keys, const QString &fromLayout = "QWERTY");

    // Layout comparison
    Q_INVOKABLE bool isLayoutSupported(const QString &layoutName);
    Q_INVOKABLE QStringList getLayoutDifferences(const QString &layout1, const QString &layout2);

signals:
    void currentLayoutChanged();
    void layoutDetected(const QString &layoutName);

private:
    QString m_currentLayout;
    QMap<QString, QMap<QString, QString>> m_layoutMaps;

    void initializeLayoutMaps();
    QString detectSystemLayout();
    QString normalizeKey(const QString &key);
};

#endif // KEYBOARDLAYOUT_H
