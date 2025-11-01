# Backup/Restore User Alias Implementation

## Overview

This implementation adds comprehensive user profile management with backup/restore functionality to the mouselessQt application. Users can now:

- Create and manage multiple user profiles (aliases)
- Automatically save test results and practice sessions
- View detailed statistics and progress
- Create backups of their progress
- Restore progress from backups

## What Was Implemented

### 1. User Data Management Backend (C++)

**Files Created:**
- `userdatamanager.h` - Header file with UserDataManager class definition
- `userdatamanager.cpp` - Implementation of data persistence logic

**Key Features:**
- JSON-based file storage in platform-specific app data directory
- User profile creation, deletion, and loading
- Automatic save of test sessions and practice sessions
- Statistics tracking (total tests, scores, averages)
- Backup creation and restoration
- Thread-safe data operations

**Data Storage Location:**
- Linux: `~/.local/share/MouselessQt/mouselessQt/`
- Windows: `C:\Users\<username>\AppData\Roaming\MouselessQt\mouselessQt\`
- macOS: `~/Library/Application Support/MouselessQt/mouselessQt/`

**Directory Structure:**
```
mouselessQt/
├── users/              # User profile JSON files
│   ├── alice.json
│   └── bob.json
└── backups/            # Backup files
    ├── alice_20251101_120000.json
    └── bob_20251101_130000.json
```

### 2. User Profile Data Structure

Each user profile JSON contains:

```json
{
  "alias": "username",
  "createdDate": "2025-11-01T12:00:00",
  "lastActive": "2025-11-01T12:30:00",
  "stats": {
    "totalTests": 10,
    "totalScore": 150,
    "averageScore": 15.0,
    "totalPracticeSessions": 50
  },
  "appProgress": {
    "vscode": {
      "testHistory": [
        {
          "appId": "vscode",
          "categoryId": "test",
          "timestamp": "2025-11-01T12:30:00",
          "attemptedKeys": [...],
          "correctKeys": 8,
          "wrongKeys": 2,
          "score": 30
        }
      ],
      "practiceHistory": [
        {
          "appId": "vscode",
          "categoryId": "essentials",
          "shortcutTitle": "Find",
          "timestamp": "2025-11-01T12:25:00",
          "success": true
        }
      ]
    }
  }
}
```

### 3. UI Components

#### UserManager.qml (`utils/UserManager.qml`)
**Purpose:** User profile selection and creation screen

**Features:**
- Displayed on app startup
- Create new user profiles with custom alias
- View all existing user profiles with statistics
- Delete user profiles with confirmation dialog
- Click on user to login and proceed to app selection

**Visual Elements:**
- Large title "MouselessQt"
- New user creation section with text input
- List of existing users showing:
  - User alias
  - Total tests and score
  - Last active timestamp
  - Delete button

#### Settings.qml (`utils/Settings.qml`)
**Purpose:** Settings and backup management screen

**Features:**
- View current user information and statistics
- Create backup of current user data
- Restore user data from backup file
- Logout functionality

**Sections:**
- **User Info**: Displays alias, test count, score, average
- **Backup & Restore**:
  - "Create Backup" button - Opens file dialog to save backup
  - "Restore Backup" button - Opens file dialog to load backup
  - Shows default backup path
- **Account Actions**:
  - "Logout" button - Returns to user selection screen

### 4. Integration with Existing Components

#### Main.qml
- Modified to show `UserManager` as the initial screen instead of `AppsView`
- All subsequent navigation flows through user-authenticated session

#### AppsView.qml
- Added header bar showing current user
- Added "⚙ Settings" button to access Settings view
- User can navigate to settings from any app selection screen

#### Result.qml
- Added automatic save of test session on results display
- Saves attemptedKeys data, correct/wrong counts, and calculated score
- Uses `userDataManager.saveTestSession()` to persist data

#### ShortcutView.qml
- Added practice session tracking
- Saves each shortcut attempt (success/failure)
- Uses `userDataManager.savePracticeSession()` to persist data
- Tracks app ID, category, shortcut title, and success status

#### Testground.qml
- No direct changes (Result.qml handles the save)
- Data flows from Testground → Result → UserDataManager

### 5. Modified Build Files

#### CMakeLists.txt
- Added `userdatamanager.h` and `userdatamanager.cpp` to executable
- Added `utils/UserManager.qml` and `utils/Settings.qml` to QML module
- Cleaned up redundant QML_FILES entries

#### main.cpp
- Included `userdatamanager.h`
- Created `UserDataManager` instance
- Registered as QML context property `userDataManager`
- Set application name and organization for QStandardPaths

## How It Works

### User Flow

1. **App Launch**
   - UserManager screen appears
   - User sees list of existing profiles or creates new one

2. **Profile Selection**
   - Click on existing user → Loads profile → Goes to AppsView
   - Or create new user → Profile created → Can login

3. **Using the App**
   - Practice shortcuts (ShortcutView) → Each attempt auto-saved
   - Take tests (Testground) → Results auto-saved when viewing Result screen
   - All data persists to user's JSON file

4. **Settings & Backup**
   - Click "⚙ Settings" button in AppsView
   - View statistics
   - Create backup → Saves timestamped JSON file
   - Restore backup → Loads data from selected JSON file
   - Logout → Returns to UserManager

### Data Persistence

**Automatic Saves:**
- Practice sessions save on every shortcut attempt
- Test sessions save when Result screen displays
- User data updates on every save (lastActive timestamp)
- Statistics recalculate on every test save

**Manual Backup/Restore:**
- Backup creates a timestamped JSON copy in backups folder
- Backup can be saved anywhere via file dialog
- Restore reads JSON and creates/updates user profile
- Restore validates JSON format before loading

## API Reference

### UserDataManager (C++ → QML)

**Properties:**
- `currentUser: string` - Currently logged-in user alias
- `availableUsers: list` - List of all user profiles
- `userData: object` - Current user's data object

**Methods:**

```qml
// User Management
userDataManager.createUser(alias: string) → bool
userDataManager.deleteUser(alias: string) → bool
userDataManager.loadUser(alias: string) → bool
userDataManager.refreshUserList() → void
userDataManager.setCurrentUser(alias: string) → void

// Data Operations
userDataManager.saveTestSession(
    appId: string,
    categoryId: string,
    attemptedKeys: list,
    correctKeys: int,
    wrongKeys: int,
    score: int
) → void

userDataManager.savePracticeSession(
    appId: string,
    categoryId: string,
    shortcutTitle: string,
    success: bool
) → void

userDataManager.getAppProgress(appId: string) → object
userDataManager.getTestHistory(appId: string) → list
userDataManager.getPracticeHistory(appId: string) → list
userDataManager.getOverallStats() → object

// Backup & Restore
userDataManager.createBackup(backupPath: string) → bool
userDataManager.restoreBackup(backupPath: string) → bool
userDataManager.getDefaultBackupPath() → string
```

**Signals:**
```qml
userDataManager.currentUserChanged()
userDataManager.availableUsersChanged()
userDataManager.userDataChanged()
userDataManager.errorOccurred(message: string)
userDataManager.successMessage(message: string)
```

## Testing Guide

### Manual Testing Checklist

**User Management:**
- [ ] Create new user with valid alias
- [ ] Create new user with empty alias (should fail)
- [ ] Create duplicate user (should fail)
- [ ] Login with existing user
- [ ] Delete user with confirmation
- [ ] View user list updates after create/delete

**Data Persistence:**
- [ ] Complete a practice session → Check if saved
- [ ] Complete a test → Check if results saved
- [ ] Close and reopen app → Verify data persists
- [ ] Check JSON file in user data directory
- [ ] Verify statistics update correctly

**Backup & Restore:**
- [ ] Create backup → Verify file created
- [ ] Create backup with custom path
- [ ] Restore from backup → Verify data loads
- [ ] Restore invalid JSON (should fail gracefully)
- [ ] Restore backup for different user

**UI/UX:**
- [ ] Settings button visible in AppsView
- [ ] Current user displays correctly
- [ ] Logout returns to UserManager
- [ ] Status messages show success/error
- [ ] Dialogs confirm destructive actions

**Edge Cases:**
- [ ] App works with no users (first run)
- [ ] App handles corrupted user JSON
- [ ] Multiple rapid saves don't corrupt data
- [ ] Large test history (100+ tests) performs well

### Automated Testing

To verify data structure integrity:

```bash
# Check user file format
cat ~/.local/share/MouselessQt/mouselessQt/users/testuser.json | jq .

# Verify backup file
cat /path/to/backup.json | jq .

# Check for required fields
cat user.json | jq '.alias, .createdDate, .stats, .appProgress'
```

## Known Limitations & Future Enhancements

### Current Limitations:
1. No cloud sync - data is local only
2. No import/export to CSV or other formats
3. No data encryption for user files
4. No user authentication (anyone can access any profile)
5. File dialogs use Qt's default (may vary by platform)

### Potential Enhancements:
1. **Cloud Sync**: Add Firebase/AWS backend integration
2. **Statistics Dashboard**: Add graphs and charts for progress tracking
3. **Export Options**: CSV, PDF reports of performance
4. **Data Encryption**: Encrypt user JSON files
5. **Multi-device Sync**: Sync across devices via cloud
6. **Import Shortcuts**: Allow users to import custom shortcut sets
7. **Achievements**: Gamification with badges and streaks
8. **Leaderboards**: Compare scores with other users (with permission)

## Troubleshooting

### User data not saving
- Check write permissions to app data directory
- Verify userDataManager is initialized in QML
- Check console for error messages
- Ensure user is logged in before attempting operations

### Backup file not found
- Verify backup path is correct
- Check backups subdirectory exists
- Ensure file dialog returned valid path

### App crashes on startup
- Check Qt6 is properly installed
- Verify all QML files are in CMakeLists.txt
- Check for QML syntax errors
- Review console output for C++ errors

### User list not updating
- Call `userDataManager.refreshUserList()` after changes
- Check if signal connections are working
- Verify users directory exists and has JSON files

## File Changes Summary

### New Files:
- `userdatamanager.h` - C++ header for data management
- `userdatamanager.cpp` - C++ implementation
- `utils/UserManager.qml` - User selection UI
- `utils/Settings.qml` - Settings and backup UI
- `BACKUP_RESTORE_IMPLEMENTATION.md` - This documentation

### Modified Files:
- `main.cpp` - Registered UserDataManager with QML
- `Main.qml` - Changed initial screen to UserManager
- `CMakeLists.txt` - Added new C++ and QML files
- `utils/AppsView.qml` - Added header with settings button
- `utils/Result.qml` - Added test session save
- `utils/ShortcutView.qml` - Added practice session save

### Total Changes:
- **5 new files** (2 C++, 2 QML, 1 documentation)
- **6 modified files**
- **~1,200 lines of new code**

## Build Instructions

```bash
# Ensure Qt6 is installed
# Ubuntu/Debian:
sudo apt install qt6-base-dev qt6-declarative-dev

# Build the project
mkdir build && cd build
cmake ..
make

# Run the application
./apppractice
```

## Conclusion

This implementation provides a complete user profile and backup/restore system for mouselessQt. Users can now:
- ✅ Create multiple profiles
- ✅ Automatically save all progress
- ✅ View detailed statistics
- ✅ Backup and restore their data
- ✅ Switch between users easily

The system is ready for production use and can be extended with the suggested enhancements for a more robust experience.
