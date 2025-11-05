import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

// Lookup/Reference Mode - Browse and search shortcuts without testing
// Inspired by Mouseless reference mode

Rectangle {
    id: root
    anchors.fill: parent
    color: "#0a0a0a"

    required property StackView stackView
    property var allApps: []
    property var filteredShortcuts: []

    Component.onCompleted: {
        loadAllApps()
        filterShortcuts()
    }

    function loadAllApps() {
        // Load from keydata.js (imported in Main.qml)
        // This will be populated with actual app data
        allApps = []
    }

    function filterShortcuts() {
        var query = searchField.text.toLowerCase()
        var selectedApp = appFilter.currentText
        var selectedCategory = categoryFilter.currentText

        var results = []

        // Search through all apps and shortcuts
        // Note: This assumes keydata structure similar to what we have
        // Will be properly implemented with full app data

        for (var i = 0; i < allApps.length; i++) {
            var app = allApps[i]

            // App filter
            if (selectedApp !== "All Apps" && app.title !== selectedApp) {
                continue
            }

            // Search through shortcuts
            if (app.sets) {
                for (var j = 0; j < app.sets.length; j++) {
                    var set = app.sets[j]

                    // Category filter
                    if (selectedCategory !== "All Categories" && set.title !== selectedCategory) {
                        continue
                    }

                    if (set.shortcuts) {
                        for (var k = 0; k < set.shortcuts.length; k++) {
                            var shortcut = set.shortcuts[k]

                            // Search filter
                            if (query === "" || shortcut.title.toLowerCase().includes(query)) {
                                results.push({
                                    title: shortcut.title,
                                    keys: shortcut.keys,
                                    app: app.title,
                                    appIcon: app.appicon || "",
                                    category: set.title
                                })
                            }
                        }
                    }
                }
            }
        }

        // Use fuzzy search if available
        if (query !== "" && typeof fuzzySearch !== 'undefined') {
            results = fuzzySearch.search(query, results, "title")
        }

        filteredShortcuts = results
        resultsList.model = filteredShortcuts
    }

    // Header with search and navigation
    Rectangle {
        id: headerBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 140
        color: "#111111"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15

            // Top navigation row
            RowLayout {
                Layout.fillWidth: true
                spacing: 15

                Button {
                    Layout.preferredHeight: 35
                    Layout.preferredWidth: 80

                    background: Rectangle {
                        color: parent.hovered ? "#1e1e1e" : "#151515"
                        radius: 6
                        border.color: "#333333"
                        border.width: 1
                    }

                    contentItem: Text {
                        text: "← Back"
                        font.pixelSize: 13
                        font.bold: true
                        color: "#ffffff"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: stackView.pop()
                }

                Text {
                    Layout.fillWidth: true
                    text: "📖 Shortcut Lookup"
                    font.pixelSize: 28
                    font.bold: true
                    color: "#6fda00"
                }

                Text {
                    text: filteredShortcuts.length + " shortcuts"
                    font.pixelSize: 14
                    color: "#888888"
                }
            }

            // Search field
            TextField {
                id: searchField
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                placeholderText: "Search shortcuts... (try 'copy', 'save', 'undo')"
                font.pixelSize: 16

                background: Rectangle {
                    color: "#1a1a1a"
                    radius: 8
                    border.color: searchField.activeFocus ? "#6fda00" : "#333333"
                    border.width: 2
                }

                color: "#ffffff"

                onTextChanged: filterShortcuts()
            }

            // Filter row
            RowLayout {
                Layout.fillWidth: true
                spacing: 15

                Text {
                    text: "Filter:"
                    font.pixelSize: 13
                    color: "#888888"
                }

                ComboBox {
                    id: appFilter
                    Layout.preferredWidth: 200
                    model: ["All Apps", "VS Code", "Firefox", "Vim", "Webflow"]

                    background: Rectangle {
                        color: "#1a1a1a"
                        radius: 6
                        border.color: "#333333"
                        border.width: 1
                    }

                    contentItem: Text {
                        text: appFilter.displayText
                        font.pixelSize: 13
                        color: "#ffffff"
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10
                    }

                    onActivated: filterShortcuts()
                }

                ComboBox {
                    id: categoryFilter
                    Layout.preferredWidth: 200
                    model: ["All Categories", "Essentials", "Editing", "Navigation", "Selection"]

                    background: Rectangle {
                        color: "#1a1a1a"
                        radius: 6
                        border.color: "#333333"
                        border.width: 1
                    }

                    contentItem: Text {
                        text: categoryFilter.displayText
                        font.pixelSize: 13
                        color: "#ffffff"
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10
                    }

                    onActivated: filterShortcuts()
                }

                Item { Layout.fillWidth: true }
            }
        }
    }

    // Results list
    ScrollView {
        anchors.top: headerBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        clip: true

        ListView {
            id: resultsList
            spacing: 8
            model: filteredShortcuts

            // Empty state
            Rectangle {
                visible: resultsList.count === 0
                anchors.centerIn: parent
                width: parent.width
                height: 200
                color: "transparent"

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 15

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "🔍"
                        font.pixelSize: 64
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: searchField.text === "" ? "Start typing to search" : "No shortcuts found"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#888888"
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: searchField.text === "" ? "Try searching for common actions" : "Try a different search term"
                        font.pixelSize: 13
                        color: "#666666"
                    }
                }
            }

            delegate: Rectangle {
                width: ListView.view.width
                height: 80
                color: mouseArea.containsMouse ? "#151515" : "#0f0f0f"
                radius: 8
                border.color: "#1a1a1a"
                border.width: 1

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 20

                    // App icon placeholder
                    Rectangle {
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50
                        radius: 8
                        color: "#1a1a1a"
                        border.color: "#6fda00"
                        border.width: 2

                        Text {
                            anchors.centerIn: parent
                            text: modelData.app ? modelData.app.substring(0, 2).toUpperCase() : "??"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#6fda00"
                        }
                    }

                    // Description column
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5

                        Text {
                            Layout.fillWidth: true
                            text: modelData.title || "Unknown"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#ffffff"
                            wrapMode: Text.WordWrap
                        }

                        Text {
                            text: (modelData.app || "Unknown App") + " • " + (modelData.category || "Uncategorized")
                            font.pixelSize: 12
                            color: "#888888"
                        }
                    }

                    // Keys display
                    Row {
                        spacing: 5

                        Repeater {
                            model: modelData.keys || []

                            Rectangle {
                                width: Math.max(keyText.width + 20, 45)
                                height: 40
                                color: "#1a1a1a"
                                radius: 6
                                border.color: "#6fda00"
                                border.width: 1

                                Text {
                                    id: keyText
                                    anchors.centerIn: parent
                                    text: modelData || ""
                                    color: "#6fda00"
                                    font.pixelSize: 14
                                    font.bold: true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
