#include "userdatamanager.h"
#include <QDebug>

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

        // Read user file to get stats
        QFile file(fileInfo.absoluteFilePath());
        if (file.open(QIODevice::ReadOnly)) {
            QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
            file.close();

            QJsonObject obj = doc.object();
            QVariantMap userInfo;
            userInfo["alias"] = alias;
            userInfo["createdDate"] = obj["createdDate"].toString();
            userInfo["lastActive"] = obj["lastActive"].toString();

            QJsonObject stats = obj["stats"].toObject();
            userInfo["totalTests"] = stats["totalTestsTaken"].toInt();
            userInfo["totalScore"] = stats["totalShortcutsCompleted"].toInt();

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
        emit successMessage("User created successfully: " + alias);
        emit availableUsersChanged();
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
        emit successMessage("User deleted: " + alias);
        emit availableUsersChanged();
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

    emit userDataChanged();
    emit successMessage("Loaded user: " + alias);
    return true;
}

void UserDataManager::refreshUserList()
{
    emit availableUsersChanged();
}

// Core progress tracking
void UserDataManager::recordTeachProgress(const QString &appId,
                                          const QString &categoryId,
                                          const QString &shortcutId,
                                          bool completed)
{
    if (m_currentUser.isEmpty()) return;

    QVariantMap progress = m_userData["progress"].toMap();
    QVariantMap appProgress = progress[appId].toMap();
    QVariantMap catProgress = appProgress[categoryId].toMap();

    QStringList completedList = catProgress["completed"].toStringList();

    if (completed && !completedList.contains(shortcutId)) {
        completedList.append(shortcutId);
        catProgress["completed"] = completedList;
        appProgress[categoryId] = catProgress;
        progress[appId] = appProgress;
        m_userData["progress"] = progress;

        saveUserData();
        emit userDataChanged();
    }
}

void UserDataManager::recordTestResult(const QString &appId,
                                        const QString &categoryId,
                                        const QString &shortcutId,
                                        bool correct)
{
    // Results are accumulated during test session and saved in endTestSession
}

QVariantMap UserDataManager::getCategoryProgress(const QString &appId, const QString &categoryId)
{
    QVariantMap progress = m_userData["progress"].toMap();
    QVariantMap appProgress = progress[appId].toMap();
    return appProgress[categoryId].toMap();
}

QVariantMap UserDataManager::getAppProgress(const QString &appId)
{
    QVariantMap progress = m_userData["progress"].toMap();
    return progress[appId].toMap();
}

QVariantMap UserDataManager::getAllProgress()
{
    return m_userData["progress"].toMap();
}

// Test session management
void UserDataManager::startTestSession(const QString &appId, const QString &categoryId)
{
    // Just track that we started - results saved at end
}

void UserDataManager::endTestSession(const QString &appId,
                                      const QString &categoryId,
                                      int correct,
                                      int wrong,
                                      int total)
{
    if (m_currentUser.isEmpty()) return;

    QString sessionKey = appId + "_" + categoryId;

    QVariantMap testHistory = m_userData["testHistory"].toMap();
    QVariantList sessions = testHistory[sessionKey].toList();

    QVariantMap session;
    session["date"] = QDateTime::currentDateTime().toString(Qt::ISODate);
    session["correct"] = correct;
    session["wrong"] = wrong;
    session["total"] = total;
    session["accuracy"] = total > 0 ? (correct * 100.0 / total) : 0.0;

    sessions.append(session);
    testHistory[sessionKey] = sessions;
    m_userData["testHistory"] = testHistory;

    // Update stats
    QVariantMap stats = m_userData["stats"].toMap();
    stats["totalTestsTaken"] = stats["totalTestsTaken"].toInt() + 1;
    m_userData["stats"] = stats;

    saveUserData();
    emit userDataChanged();
}

QVariantList UserDataManager::getTestHistory(const QString &appId, const QString &categoryId, int limit)
{
    QString sessionKey = appId + "_" + categoryId;
    QVariantMap testHistory = m_userData["testHistory"].toMap();
    QVariantList sessions = testHistory[sessionKey].toList();

    // Return last N sessions
    if (limit > 0 && sessions.size() > limit) {
        return sessions.mid(sessions.size() - limit);
    }
    return sessions;
}

// Last position tracking
void UserDataManager::saveLastPosition(const QString &appId,
                                        const QString &categoryId,
                                        int shortcutIndex)
{
    if (m_currentUser.isEmpty()) return;

    QVariantMap lastPos;
    lastPos["appId"] = appId;
    lastPos["categoryId"] = categoryId;
    lastPos["shortcutIndex"] = shortcutIndex;

    m_userData["lastPosition"] = lastPos;
    saveUserData();
}

QVariantMap UserDataManager::getLastPosition()
{
    return m_userData["lastPosition"].toMap();
}

// Summary stats
QVariantMap UserDataManager::getSummaryStats()
{
    return m_userData["stats"].toMap();
}

int UserDataManager::getTotalShortcutsCompleted()
{
    QVariantMap progress = m_userData["progress"].toMap();
    int total = 0;

    for (const QString &appId : progress.keys()) {
        QVariantMap appProgress = progress[appId].toMap();
        for (const QString &catId : appProgress.keys()) {
            QVariantMap catProgress = appProgress[catId].toMap();
            total += catProgress["completed"].toStringList().size();
        }
    }

    return total;
}

int UserDataManager::getTotalCategoriesCompleted()
{
    QVariantMap progress = m_userData["progress"].toMap();
    int total = 0;

    for (const QString &appId : progress.keys()) {
        QVariantMap appProgress = progress[appId].toMap();
        for (const QString &catId : appProgress.keys()) {
            QVariantMap catProgress = appProgress[catId].toMap();
            int completed = catProgress["completed"].toStringList().size();
            int totalShortcuts = catProgress["total"].toInt();
            if (completed >= totalShortcuts && totalShortcuts > 0) {
                total++;
            }
        }
    }

    return total;
}

double UserDataManager::getOverallAccuracy()
{
    QVariantMap testHistory = m_userData["testHistory"].toMap();
    int totalCorrect = 0;
    int totalAttempts = 0;

    for (const QString &key : testHistory.keys()) {
        QVariantList sessions = testHistory[key].toList();
        for (const QVariant &sessionVar : sessions) {
            QVariantMap session = sessionVar.toMap();
            totalCorrect += session["correct"].toInt();
            totalAttempts += session["total"].toInt();
        }
    }

    return totalAttempts > 0 ? (totalCorrect * 100.0 / totalAttempts) : 0.0;
}

// Backup and restore
bool UserDataManager::createBackup(const QString &backupPath)
{
    if (m_currentUser.isEmpty()) {
        emit errorOccurred("No user loaded");
        return false;
    }

    QString sourcePath = getUserFilePath(m_currentUser);
    QFile sourceFile(sourcePath);

    if (!sourceFile.exists()) {
        emit errorOccurred("User file does not exist");
        return false;
    }

    if (QFile::exists(backupPath)) {
        QFile::remove(backupPath);
    }

    if (sourceFile.copy(backupPath)) {
        emit successMessage("Backup created successfully");
        return true;
    }

    emit errorOccurred("Failed to create backup");
    return false;
}

bool UserDataManager::restoreBackup(const QString &backupPath)
{
    QFile backupFile(backupPath);

    if (!backupFile.exists()) {
        emit errorOccurred("Backup file does not exist");
        return false;
    }

    if (!backupFile.open(QIODevice::ReadOnly)) {
        emit errorOccurred("Failed to open backup file");
        return false;
    }

    QJsonDocument doc = QJsonDocument::fromJson(backupFile.readAll());
    backupFile.close();

    QString alias = doc.object()["alias"].toString();
    if (alias.isEmpty()) {
        emit errorOccurred("Invalid backup file");
        return false;
    }

    QString destPath = getUserFilePath(alias);
    QFile destFile(destPath);

    if (destFile.exists()) {
        destFile.remove();
    }

    if (QFile::copy(backupPath, destPath)) {
        emit successMessage("Backup restored successfully");
        loadUser(alias);
        return true;
    }

    emit errorOccurred("Failed to restore backup");
    return false;
}

QString UserDataManager::getDefaultBackupPath()
{
    QString timestamp = QDateTime::currentDateTime().toString("yyyyMMdd_HHmmss");
    return m_dataDir.absolutePath() + "/backups/" + m_currentUser + "_" + timestamp + ".json";
}

// Private methods
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
    m_userData["lastPosition"] = QVariantMap();
    m_userData["progress"] = QVariantMap();
    m_userData["testHistory"] = QVariantMap();

    QVariantMap stats;
    stats["totalShortcutsCompleted"] = 0;
    stats["totalCategoriesCompleted"] = 0;
    stats["totalTestsTaken"] = 0;
    stats["overallAccuracy"] = 0.0;
    m_userData["stats"] = stats;

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
        qWarning() << "Failed to open file for writing:" << filePath;
        return false;
    }

    // Update stats before saving
    QVariantMap stats = m_userData["stats"].toMap();
    stats["totalShortcutsCompleted"] = getTotalShortcutsCompleted();
    stats["totalCategoriesCompleted"] = getTotalCategoriesCompleted();
    stats["overallAccuracy"] = getOverallAccuracy();
    m_userData["stats"] = stats;

    QJsonDocument doc(variantMapToJson(m_userData));
    file.write(doc.toJson(QJsonDocument::Indented));
    file.close();

    return true;
}

// JSON conversion helpers
QJsonObject UserDataManager::variantMapToJson(const QVariantMap &map)
{
    QJsonObject obj;
    for (auto it = map.constBegin(); it != map.constEnd(); ++it) {
        if (it.value().type() == QVariant::Map) {
            obj[it.key()] = variantMapToJson(it.value().toMap());
        } else if (it.value().type() == QVariant::List) {
            obj[it.key()] = variantListToJson(it.value().toList());
        } else {
            obj[it.key()] = QJsonValue::fromVariant(it.value());
        }
    }
    return obj;
}

QJsonArray UserDataManager::variantListToJson(const QVariantList &list)
{
    QJsonArray arr;
    for (const QVariant &item : list) {
        if (item.type() == QVariant::Map) {
            arr.append(variantMapToJson(item.toMap()));
        } else if (item.type() == QVariant::List) {
            arr.append(variantListToJson(item.toList()));
        } else {
            arr.append(QJsonValue::fromVariant(item));
        }
    }
    return arr;
}

QVariantMap UserDataManager::jsonToVariantMap(const QJsonObject &json)
{
    QVariantMap map;
    for (auto it = json.constBegin(); it != json.constEnd(); ++it) {
        if (it.value().isObject()) {
            map[it.key()] = jsonToVariantMap(it.value().toObject());
        } else if (it.value().isArray()) {
            map[it.key()] = jsonToVariantList(it.value().toArray());
        } else {
            map[it.key()] = it.value().toVariant();
        }
    }
    return map;
}

QVariantList UserDataManager::jsonToVariantList(const QJsonArray &array)
{
    QVariantList list;
    for (const QJsonValue &value : array) {
        if (value.isObject()) {
            list.append(jsonToVariantMap(value.toObject()));
        } else if (value.isArray()) {
            list.append(jsonToVariantList(value.toArray()));
        } else {
            list.append(value.toVariant());
        }
    }
    return list;
}
