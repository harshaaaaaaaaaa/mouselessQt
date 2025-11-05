#include "userdatamanager.h"
#include <QDebug>
#include <QRandomGenerator>

UserDataManager::UserDataManager(QObject *parent)
    : QObject(parent)
{
    // Set data directory to app data location
    QString dataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    m_dataDir = QDir(dataPath + "/mouselessQt");

    if (!m_dataDir.exists()) {
        m_dataDir.mkpath(".");
    }

    // Create users subdirectory
    if (!m_dataDir.exists("users")) {
        m_dataDir.mkpath("users");
    }

    // Create backups subdirectory
    if (!m_dataDir.exists("backups")) {
        m_dataDir.mkpath("backups");
    }

    refreshUserList();
}

QString UserDataManager::currentUser() const
{
    return m_currentUser;
}

void UserDataManager::setCurrentUser(const QString &alias)
{
    if (m_currentUser != alias) {
        m_currentUser = alias;
        emit currentUserChanged();

        if (!alias.isEmpty()) {
            loadUser(alias);
        }
    }
}

QVariantList UserDataManager::availableUsers() const
{
    QVariantList users;
    QDir usersDir(m_dataDir.absolutePath() + "/users");
    QStringList filters;
    filters << "*.json";

    QFileInfoList fileList = usersDir.entryInfoList(filters, QDir::Files);

    for (const QFileInfo &fileInfo : fileList) {
        QString alias = fileInfo.baseName();

        // Read user file to get additional info
        QFile file(fileInfo.absoluteFilePath());
        if (file.open(QIODevice::ReadOnly)) {
            QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
            file.close();

            QJsonObject obj = doc.object();
            QVariantMap userInfo;
            userInfo["alias"] = alias;
            userInfo["createdDate"] = obj["createdDate"].toString();
            userInfo["lastActive"] = obj["lastActive"].toString();
            userInfo["totalTests"] = obj["stats"].toObject()["totalTests"].toInt();
            userInfo["totalScore"] = obj["stats"].toObject()["totalScore"].toInt();

            users.append(userInfo);
        }
    }

    return users;
}

QVariantMap UserDataManager::userData() const
{
    return m_userData;
}

bool UserDataManager::createUser(const QString &alias)
{
    if (alias.isEmpty()) {
        emit errorOccurred("User alias cannot be empty");
        return false;
    }

    QString filePath = getUserFilePath(alias);
    QFile file(filePath);

    if (file.exists()) {
        emit errorOccurred("User already exists");
        return false;
    }

    initializeUserData(alias);

    if (saveUserData()) {
        emit successMessage("User created successfully");
        refreshUserList();
        return true;
    }

    return false;
}

bool UserDataManager::deleteUser(const QString &alias)
{
    QString filePath = getUserFilePath(alias);
    QFile file(filePath);

    if (!file.exists()) {
        emit errorOccurred("User does not exist");
        return false;
    }

    if (file.remove()) {
        if (m_currentUser == alias) {
            m_currentUser.clear();
            m_userData.clear();
            emit currentUserChanged();
            emit userDataChanged();
        }

        emit successMessage("User deleted successfully");
        refreshUserList();
        return true;
    }

    emit errorOccurred("Failed to delete user");
    return false;
}

bool UserDataManager::loadUser(const QString &alias)
{
    QString filePath = getUserFilePath(alias);
    QFile file(filePath);

    if (!file.exists()) {
        emit errorOccurred("User does not exist");
        return false;
    }

    if (!file.open(QIODevice::ReadOnly)) {
        emit errorOccurred("Failed to open user file");
        return false;
    }

    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    file.close();

    m_userData = jsonToVariantMap(doc.object());
    m_currentUser = alias;

    // Update last active time
    m_userData["lastActive"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    saveUserData();

    emit currentUserChanged();
    emit userDataChanged();
    emit successMessage("User loaded successfully");

    return true;
}

void UserDataManager::refreshUserList()
{
    emit availableUsersChanged();
}

void UserDataManager::saveTestSession(const QString &appId,
                                      const QString &categoryId,
                                      const QVariantList &attemptedKeys,
                                      int correctKeys,
                                      int wrongKeys,
                                      int score)
{
    if (m_currentUser.isEmpty()) {
        emit errorOccurred("No user logged in");
        return;
    }

    QVariantMap session;
    session["appId"] = appId;
    session["categoryId"] = categoryId;
    session["timestamp"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    session["attemptedKeys"] = attemptedKeys;
    session["correctKeys"] = correctKeys;
    session["wrongKeys"] = wrongKeys;
    session["score"] = score;

    // Get or create appProgress map
    QVariantMap appProgress = m_userData.value("appProgress").toMap();
    QVariantMap appData = appProgress.value(appId).toMap();

    // Add to test history
    QVariantList testHistory = appData.value("testHistory").toList();
    testHistory.append(session);
    appData["testHistory"] = testHistory;

    // Update app progress
    appProgress[appId] = appData;
    m_userData["appProgress"] = appProgress;

    updateStats();
    saveUserData();

    emit userDataChanged();
}

void UserDataManager::savePracticeSession(const QString &appId,
                                          const QString &categoryId,
                                          const QString &shortcutTitle,
                                          bool success)
{
    if (m_currentUser.isEmpty()) {
        emit errorOccurred("No user logged in");
        return;
    }

    QVariantMap session;
    session["appId"] = appId;
    session["categoryId"] = categoryId;
    session["shortcutTitle"] = shortcutTitle;
    session["timestamp"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    session["success"] = success;

    // Get or create appProgress map
    QVariantMap appProgress = m_userData.value("appProgress").toMap();
    QVariantMap appData = appProgress.value(appId).toMap();

    // Add to practice history
    QVariantList practiceHistory = appData.value("practiceHistory").toList();
    practiceHistory.append(session);
    appData["practiceHistory"] = practiceHistory;

    // Update app progress
    appProgress[appId] = appData;
    m_userData["appProgress"] = appProgress;

    saveUserData();
    emit userDataChanged();
}

QVariantMap UserDataManager::getAppProgress(const QString &appId)
{
    QVariantMap appProgress = m_userData.value("appProgress").toMap();
    return appProgress.value(appId).toMap();
}

QVariantList UserDataManager::getTestHistory(const QString &appId)
{
    QVariantMap appData = getAppProgress(appId);
    return appData.value("testHistory").toList();
}

QVariantList UserDataManager::getPracticeHistory(const QString &appId)
{
    QVariantMap appData = getAppProgress(appId);
    return appData.value("practiceHistory").toList();
}

QVariantMap UserDataManager::getOverallStats()
{
    return m_userData.value("stats").toMap();
}

void UserDataManager::saveSessionState(const QString &appId,
                                        const QString &sessionType,
                                        const QVariantMap &sessionData)
{
    if (m_currentUser.isEmpty()) {
        return;
    }

    // Get or create appProgress map
    QVariantMap appProgress = m_userData.value("appProgress").toMap();
    QVariantMap appData = appProgress.value(appId).toMap();

    // Save session state under sessionStates key
    QVariantMap sessionStates = appData.value("sessionStates").toMap();
    sessionStates[sessionType] = sessionData;
    appData["sessionStates"] = sessionStates;

    // Update app progress
    appProgress[appId] = appData;
    m_userData["appProgress"] = appProgress;

    saveUserData();
}

QVariantMap UserDataManager::loadSessionState(const QString &appId,
                                              const QString &sessionType)
{
    QVariantMap appData = getAppProgress(appId);
    QVariantMap sessionStates = appData.value("sessionStates").toMap();
    return sessionStates.value(sessionType).toMap();
}

void UserDataManager::clearSessionState(const QString &appId,
                                        const QString &sessionType)
{
    if (m_currentUser.isEmpty()) {
        return;
    }

    QVariantMap appProgress = m_userData.value("appProgress").toMap();
    QVariantMap appData = appProgress.value(appId).toMap();
    QVariantMap sessionStates = appData.value("sessionStates").toMap();

    // Remove the session state
    sessionStates.remove(sessionType);
    appData["sessionStates"] = sessionStates;
    appProgress[appId] = appData;
    m_userData["appProgress"] = appProgress;

    saveUserData();
}

bool UserDataManager::createBackup(const QString &backupPath)
{
    if (m_currentUser.isEmpty()) {
        emit errorOccurred("No user logged in");
        return false;
    }

    QString path = backupPath;
    if (path.isEmpty()) {
        path = getDefaultBackupPath();
    }

    QFile file(path);
    if (!file.open(QIODevice::WriteOnly)) {
        emit errorOccurred("Failed to create backup file");
        return false;
    }

    QJsonDocument doc(variantMapToJson(m_userData));
    file.write(doc.toJson(QJsonDocument::Indented));
    file.close();

    emit successMessage("Backup created successfully at: " + path);
    return true;
}

bool UserDataManager::restoreBackup(const QString &backupPath)
{
    QFile file(backupPath);

    if (!file.exists()) {
        emit errorOccurred("Backup file does not exist");
        return false;
    }

    if (!file.open(QIODevice::ReadOnly)) {
        emit errorOccurred("Failed to open backup file");
        return false;
    }

    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    file.close();

    if (doc.isNull() || !doc.isObject()) {
        emit errorOccurred("Invalid backup file format");
        return false;
    }

    QVariantMap restoredData = jsonToVariantMap(doc.object());
    QString alias = restoredData.value("alias").toString();

    if (alias.isEmpty()) {
        emit errorOccurred("Backup file does not contain user alias");
        return false;
    }

    m_userData = restoredData;
    m_currentUser = alias;

    // Update last active time
    m_userData["lastActive"] = QDateTime::currentDateTime().toString(Qt::ISODate);

    if (saveUserData()) {
        emit currentUserChanged();
        emit userDataChanged();
        emit successMessage("Backup restored successfully");
        refreshUserList();
        return true;
    }

    return false;
}

QString UserDataManager::getDefaultBackupPath()
{
    QString timestamp = QDateTime::currentDateTime().toString("yyyyMMdd_HHmmss");
    QString backupDir = m_dataDir.absolutePath() + "/backups";
    return backupDir + "/" + m_currentUser + "_" + timestamp + ".json";
}

QString UserDataManager::getUserFilePath(const QString &alias) const
{
    return m_dataDir.absolutePath() + "/users/" + alias + ".json";
}

void UserDataManager::initializeUserData(const QString &alias)
{
    m_userData.clear();
    m_userData["alias"] = alias;
    m_userData["createdDate"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    m_userData["lastActive"] = QDateTime::currentDateTime().toString(Qt::ISODate);

    QVariantMap stats;
    stats["totalTests"] = 0;
    stats["totalScore"] = 0;
    stats["averageScore"] = 0.0;
    stats["totalPracticeSessions"] = 0;
    m_userData["stats"] = stats;

    m_userData["appProgress"] = QVariantMap();

    m_currentUser = alias;
}

bool UserDataManager::saveUserData()
{
    if (m_currentUser.isEmpty()) {
        return false;
    }

    QString filePath = getUserFilePath(m_currentUser);
    QFile file(filePath);

    if (!file.open(QIODevice::WriteOnly)) {
        emit errorOccurred("Failed to save user data");
        return false;
    }

    QJsonDocument doc(variantMapToJson(m_userData));
    file.write(doc.toJson(QJsonDocument::Indented));
    file.close();

    return true;
}

void UserDataManager::updateStats()
{
    QVariantMap stats = m_userData.value("stats").toMap();
    QVariantMap appProgress = m_userData.value("appProgress").toMap();

    int totalTests = 0;
    int totalScore = 0;

    // Calculate totals from all apps
    for (const QString &appId : appProgress.keys()) {
        QVariantMap appData = appProgress.value(appId).toMap();
        QVariantList testHistory = appData.value("testHistory").toList();

        totalTests += testHistory.size();

        for (const QVariant &test : testHistory) {
            QVariantMap testData = test.toMap();
            totalScore += testData.value("score").toInt();
        }
    }

    stats["totalTests"] = totalTests;
    stats["totalScore"] = totalScore;
    stats["averageScore"] = totalTests > 0 ? (double)totalScore / totalTests : 0.0;

    m_userData["stats"] = stats;
}

// Weighted Learning Algorithm Implementation
QVariantMap UserDataManager::getWeightedShortcut(const QString &appId,
                                                   const QString &categoryId,
                                                   const QVariantList &allShortcuts)
{
    if (m_currentUser.isEmpty() || allShortcuts.isEmpty()) {
        return QVariantMap();
    }

    // Build weighted pool based on learning levels
    QVector<QPair<QVariantMap, int>> weightedPool;

    for (const QVariant &shortcut : allShortcuts) {
        QVariantMap shortcutMap = shortcut.toMap();
        QString shortcutId = shortcutMap.value("title").toString();

        // Get shortcut stats
        QVariantMap stats = getShortcutStats(appId, categoryId, shortcutId);
        int attemptCount = stats.value("attemptCount", 0).toInt();
        int successCount = stats.value("successCount", 0).toInt();
        QString level = stats.value("level", "new").toString();

        // Assign weight based on learning level
        int weight = 0;
        if (level == "new" || attemptCount == 0) {
            weight = 90;  // 90% weight for new shortcuts
        } else if (level == "trained") {
            weight = 50;  // 50% weight for trained shortcuts
        } else if (level == "learned") {
            weight = 10;  // 10% weight for learned shortcuts (for review)
        }

        weightedPool.append({shortcutMap, weight});
    }

    // Calculate total weight
    int totalWeight = 0;
    for (const auto &pair : weightedPool) {
        totalWeight += pair.second;
    }

    if (totalWeight == 0) {
        // If all weights are 0, return random
        int randomIndex = QRandomGenerator::global()->bounded(allShortcuts.size());
        return allShortcuts[randomIndex].toMap();
    }

    // Weighted random selection
    int random = QRandomGenerator::global()->bounded(totalWeight);
    int cumulative = 0;

    for (const auto &pair : weightedPool) {
        cumulative += pair.second;
        if (random < cumulative) {
            return pair.first;
        }
    }

    // Fallback: return first shortcut
    return allShortcuts.first().toMap();
}

void UserDataManager::updateShortcutLevel(const QString &appId,
                                           const QString &categoryId,
                                           const QString &shortcutId,
                                           bool success)
{
    if (m_currentUser.isEmpty()) {
        return;
    }

    // Get or create shortcut stats
    QVariantMap appProgress = m_userData.value("appProgress").toMap();
    QVariantMap appData = appProgress.value(appId).toMap();
    QVariantMap shortcutStats = appData.value("shortcutStats").toMap();
    QVariantMap categoryStats = shortcutStats.value(categoryId).toMap();
    QVariantMap stats = categoryStats.value(shortcutId).toMap();

    // Update counts
    int attemptCount = stats.value("attemptCount", 0).toInt() + 1;
    int successCount = stats.value("successCount", 0).toInt() + (success ? 1 : 0);
    int failureCount = stats.value("failureCount", 0).toInt() + (success ? 0 : 1);

    stats["attemptCount"] = attemptCount;
    stats["successCount"] = successCount;
    stats["failureCount"] = failureCount;
    stats["lastAttempt"] = QDateTime::currentDateTime().toString(Qt::ISODate);

    // Determine learning level based on performance
    QString level = "new";
    if (attemptCount >= 5 && successCount >= 4) {
        level = "learned";  // 80%+ success rate over 5+ attempts
    } else if (attemptCount >= 2 && successCount >= 1) {
        level = "trained";  // At least one success
    }

    stats["level"] = level;

    // Save back
    categoryStats[shortcutId] = stats;
    shortcutStats[categoryId] = categoryStats;
    appData["shortcutStats"] = shortcutStats;
    appProgress[appId] = appData;
    m_userData["appProgress"] = appProgress;

    saveUserData();
}

QVariantMap UserDataManager::getShortcutStats(const QString &appId,
                                              const QString &categoryId,
                                              const QString &shortcutId)
{
    if (m_currentUser.isEmpty()) {
        return QVariantMap();
    }

    QVariantMap appProgress = m_userData.value("appProgress").toMap();
    QVariantMap appData = appProgress.value(appId).toMap();
    QVariantMap shortcutStats = appData.value("shortcutStats").toMap();
    QVariantMap categoryStats = shortcutStats.value(categoryId).toMap();
    QVariantMap stats = categoryStats.value(shortcutId).toMap();

    // Return stats with defaults
    if (stats.isEmpty()) {
        stats["attemptCount"] = 0;
        stats["successCount"] = 0;
        stats["failureCount"] = 0;
        stats["level"] = "new";
        stats["lastAttempt"] = "";
    }

    return stats;
}

int UserDataManager::getUnlockedCount(const QString &appId, const QString &categoryId)
{
    if (m_currentUser.isEmpty()) {
        return 0;
    }

    QVariantMap appProgress = m_userData.value("appProgress").toMap();
    QVariantMap appData = appProgress.value(appId).toMap();
    QVariantMap shortcutStats = appData.value("shortcutStats").toMap();
    QVariantMap categoryStats = shortcutStats.value(categoryId).toMap();

    int unlockedCount = 0;
    for (const QString &shortcutId : categoryStats.keys()) {
        QVariantMap stats = categoryStats.value(shortcutId).toMap();
        QString level = stats.value("level", "new").toString();

        // Count trained and learned shortcuts
        if (level == "trained" || level == "learned") {
            unlockedCount++;
        }
    }

    return unlockedCount;
}

int UserDataManager::getLearnedCount(const QString &appId, const QString &categoryId)
{
    if (m_currentUser.isEmpty()) {
        return 0;
    }

    QVariantMap appProgress = m_userData.value("appProgress").toMap();
    QVariantMap appData = appProgress.value(appId).toMap();
    QVariantMap shortcutStats = appData.value("shortcutStats").toMap();
    QVariantMap categoryStats = shortcutStats.value(categoryId).toMap();

    int learnedCount = 0;
    for (const QString &shortcutId : categoryStats.keys()) {
        QVariantMap stats = categoryStats.value(shortcutId).toMap();
        QString level = stats.value("level", "new").toString();

        // Count only learned shortcuts (80%+ success rate)
        if (level == "learned") {
            learnedCount++;
        }
    }

    return learnedCount;
}

QJsonObject UserDataManager::variantMapToJson(const QVariantMap &map)
{
    QJsonObject obj;

    for (auto it = map.begin(); it != map.end(); ++it) {
        const QString &key = it.key();
        const QVariant &value = it.value();

        if (value.type() == QVariant::Map) {
            obj[key] = variantMapToJson(value.toMap());
        } else if (value.type() == QVariant::List) {
            obj[key] = variantListToJson(value.toList());
        } else {
            obj[key] = QJsonValue::fromVariant(value);
        }
    }

    return obj;
}

QJsonArray UserDataManager::variantListToJson(const QVariantList &list)
{
    QJsonArray arr;

    for (const QVariant &value : list) {
        if (value.type() == QVariant::Map) {
            arr.append(variantMapToJson(value.toMap()));
        } else if (value.type() == QVariant::List) {
            arr.append(variantListToJson(value.toList()));
        } else {
            arr.append(QJsonValue::fromVariant(value));
        }
    }

    return arr;
}

QVariantMap UserDataManager::jsonToVariantMap(const QJsonObject &json)
{
    return json.toVariantMap();
}

QVariantList UserDataManager::jsonToVariantList(const QJsonArray &array)
{
    return array.toVariantList();
}
