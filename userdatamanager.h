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

    // Core progress tracking
    Q_INVOKABLE void recordTeachProgress(const QString &appId,
                                         const QString &categoryId,
                                         const QString &shortcutId,
                                         bool completed);

    Q_INVOKABLE void recordTestResult(const QString &appId,
                                      const QString &categoryId,
                                      const QString &shortcutId,
                                      bool correct);

    // Progress queries
    Q_INVOKABLE QVariantMap getCategoryProgress(const QString &appId, const QString &categoryId);
    Q_INVOKABLE QVariantMap getAppProgress(const QString &appId);
    Q_INVOKABLE QVariantMap getAllProgress();

    // Test session management
    Q_INVOKABLE void startTestSession(const QString &appId, const QString &categoryId);
    Q_INVOKABLE void endTestSession(const QString &appId,
                                     const QString &categoryId,
                                     int correct,
                                     int wrong,
                                     int total);
    Q_INVOKABLE QVariantList getTestHistory(const QString &appId, const QString &categoryId, int limit = 3);

    // Last position tracking
    Q_INVOKABLE void saveLastPosition(const QString &appId,
                                       const QString &categoryId,
                                       int shortcutIndex);
    Q_INVOKABLE QVariantMap getLastPosition();

    // Summary stats
    Q_INVOKABLE QVariantMap getSummaryStats();
    Q_INVOKABLE int getTotalShortcutsCompleted();
    Q_INVOKABLE int getTotalCategoriesCompleted();
    Q_INVOKABLE double getOverallAccuracy();

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
    QJsonObject variantMapToJson(const QVariantMap &map);
    QJsonArray variantListToJson(const QVariantList &list);
    QVariantMap jsonToVariantMap(const QJsonObject &json);
    QVariantList jsonToVariantList(const QJsonArray &array);
};

#endif // USERDATAMANAGER_H
