#ifndef USERDATAMANAGER_H
#define USERDATAMANAGER_H

#include <QObject>
#include <QString>
#include <QVariantMap>
#include <QVariantList>
#include <QDateTime>
#include <QDir>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QStandardPaths>

class UserDataManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentUser READ currentUser WRITE setCurrentUser NOTIFY currentUserChanged)
    Q_PROPERTY(QVariantList availableUsers READ availableUsers NOTIFY availableUsersChanged)
    Q_PROPERTY(QVariantMap userData READ userData NOTIFY userDataChanged)

public:
    explicit UserDataManager(QObject *parent = nullptr);

    QString currentUser() const;
    void setCurrentUser(const QString &alias);

    QVariantList availableUsers() const;
    QVariantMap userData() const;

    // User management
    Q_INVOKABLE bool createUser(const QString &alias);
    Q_INVOKABLE bool deleteUser(const QString &alias);
    Q_INVOKABLE bool loadUser(const QString &alias);
    Q_INVOKABLE void refreshUserList();

    // Data operations
    Q_INVOKABLE void saveTestSession(const QString &appId,
                                     const QString &categoryId,
                                     const QVariantList &attemptedKeys,
                                     int correctKeys,
                                     int wrongKeys,
                                     int score);

    Q_INVOKABLE void savePracticeSession(const QString &appId,
                                         const QString &categoryId,
                                         const QString &shortcutTitle,
                                         bool success);

    Q_INVOKABLE QVariantMap getAppProgress(const QString &appId);
    Q_INVOKABLE QVariantList getTestHistory(const QString &appId);
    Q_INVOKABLE QVariantList getPracticeHistory(const QString &appId);
    Q_INVOKABLE QVariantMap getOverallStats();

    // Weighted learning algorithm
    Q_INVOKABLE QVariantMap getWeightedShortcut(const QString &appId,
                                                 const QString &categoryId,
                                                 const QVariantList &allShortcuts);
    Q_INVOKABLE void updateShortcutLevel(const QString &appId,
                                         const QString &categoryId,
                                         const QString &shortcutId,
                                         bool success);
    Q_INVOKABLE QVariantMap getShortcutStats(const QString &appId,
                                             const QString &categoryId,
                                             const QString &shortcutId);
    Q_INVOKABLE int getUnlockedCount(const QString &appId, const QString &categoryId);
    Q_INVOKABLE int getLearnedCount(const QString &appId, const QString &categoryId);

    // Session state management
    Q_INVOKABLE void saveSessionState(const QString &appId,
                                       const QString &sessionType,
                                       const QVariantMap &sessionData);
    Q_INVOKABLE QVariantMap loadSessionState(const QString &appId,
                                             const QString &sessionType);
    Q_INVOKABLE void clearSessionState(const QString &appId,
                                       const QString &sessionType);

    // Backup and restore
    Q_INVOKABLE bool createBackup(const QString &backupPath);
    Q_INVOKABLE bool restoreBackup(const QString &backupPath);
    Q_INVOKABLE QString getDefaultBackupPath();

signals:
    void currentUserChanged();
    void availableUsersChanged();
    void userDataChanged();
    void errorOccurred(const QString &message);
    void successMessage(const QString &message);

private:
    QString m_currentUser;
    QVariantMap m_userData;
    QDir m_dataDir;

    QString getUserFilePath(const QString &alias) const;
    void initializeUserData(const QString &alias);
    bool saveUserData();
    void updateStats();
    QJsonObject variantMapToJson(const QVariantMap &map);
    QJsonArray variantListToJson(const QVariantList &list);
    QVariantMap jsonToVariantMap(const QJsonObject &json);
    QVariantList jsonToVariantList(const QJsonArray &array);
};

#endif // USERDATAMANAGER_H
