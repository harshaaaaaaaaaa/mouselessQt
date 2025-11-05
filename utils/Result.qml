import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Shapes
import QtQuick.Controls 2.15

Rectangle{
     id:root
     anchors.fill: parent
     color:"#0a0a0a"
     visible: true

     required property var appsdata
     required property StackView stackView
     required property var attemptedKeys
     property int correctkey: 0
     property int wrongkey: 0

     function updateKeyCounts() {
         let correct = 0;
         let wrong = 0;
         for (let i = 0; i < attemptedKeys.length; i++) {
             if (attemptedKeys[i].correct === true) correct++;
             if (attemptedKeys[i].attempt === true && attemptedKeys[i].correct === false) wrong++;
         }
         correctkey = correct;
         wrongkey = wrong;
     }

    Component.onCompleted: {
        updateKeyCounts()
        saveTestSession()
    }
    onAttemptedKeysChanged: updateKeyCounts()

    function saveTestSession() {
        var score = 4*correctkey - wrongkey
        userDataManager.saveTestSession(
            appsdata.id,
            appsdata.test ? "test" : "unknown",
            attemptedKeys,
            correctkey,
            wrongkey,
            score
        )
        // Clear session state since test is complete
        userDataManager.clearSessionState(appsdata.id || "unknown", "testground")
    }

    // Header with navigation
    Rectangle {
        id: headerBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 50
        color: "#111111"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

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

            Item { Layout.fillWidth: true }

            Button {
                Layout.preferredHeight: 35
                Layout.preferredWidth: 80

                background: Rectangle {
                    color: parent.hovered ? "#6fda00" : "#151515"
                    radius: 6
                    border.color: "#6fda00"
                    border.width: 1
                }

                contentItem: Text {
                    text: "🏠 Home"
                    font.pixelSize: 13
                    font.bold: true
                    color: parent.parent.hovered ? "#000000" : "#6fda00"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    // Go back to home (AppsView)
                    while (stackView.depth > 1) {
                        stackView.pop()
                    }
                }
            }
        }
    }

    Row {
          visible: true
          spacing: 20
          anchors{
                 top: headerBar.bottom
                 topMargin: 30
                horizontalCenter: parent.horizontalCenter
            }
         Text {
                id: score
                text: "Score: " + `${4*correctkey-wrongkey}/${4*attemptedKeys.length}`
                font.bold: true
                font.pixelSize: 32
                color:"#6fda00"
             }
         Rectangle{
                  id:keyAnalysis
                  height:45
                  width:140
                  radius: 8
                  color: mouseArea.containsMouse ? "#7fea10" : "#6fda00"

                  MouseArea {
                      id: mouseArea
                      anchors.fill: parent
                      hoverEnabled: true
                      onClicked: {
                          stackView.push("KeyAnalysis.qml", {
                             attemptedKeys:attemptedKeys,
                              appsdata:appsdata,
                              stackView: stackView
                          })
                      }
                  }

           Text {
                anchors.centerIn: parent
                id: mark
                text: "Key Analysis"
                font.bold: true
                font.pixelSize: 14
                color:"#000000"
             }
         }

         // Retry Failed Shortcuts Button
         Rectangle{
                  id: retryButton
                  height:45
                  width:160
                  radius: 8
                  color: retryMouseArea.containsMouse ? "#ff5555" : "#ff4444"
                  visible: wrongkey > 0

                  MouseArea {
                      id: retryMouseArea
                      anchors.fill: parent
                      hoverEnabled: true
                      onClicked: {
                          // Filter only failed shortcuts
                          var failedShortcuts = []
                          for (var i = 0; i < attemptedKeys.length; i++) {
                              if (attemptedKeys[i].attempt === true && attemptedKeys[i].correct === false) {
                                  // Find original shortcut data
                                  for (var j = 0; j < appsdata.shortcuts.length; j++) {
                                      if (appsdata.shortcuts[j].title === attemptedKeys[i].title) {
                                          failedShortcuts.push(appsdata.shortcuts[j])
                                          break
                                      }
                                  }
                              }
                          }

                          // Start new test with only failed shortcuts
                          if (failedShortcuts.length > 0) {
                              var retryData = {
                                  id: appsdata.id,
                                  title: appsdata.title,
                                  test: appsdata.test,
                                  shortcuts: failedShortcuts,
                                  isRetry: true
                              }

                              stackView.push("Testground.qml", {
                                  appsdata: retryData,
                                  stackView: stackView
                              })
                          }
                      }
                  }

           Text {
                anchors.centerIn: parent
                text: "🔄 Retry Failed (" + wrongkey + ")"
                font.bold: true
                font.pixelSize: 13
                color:"#ffffff"
             }
         }
       }


     Shape{
         id:shape

         property real progress: 0.0
         anchors.centerIn: parent
         width:300
         height:300

         smooth:true
         antialiasing: true
         ShapePath{
             strokeWidth: 30
             fillColor: root.color
             strokeColor: "#7cfc00"

             PathAngleArc{
                 centerX: shape.width/2
                 centerY: shape.height/2
                 radiusX: shape.width/2
                 radiusY: shape.height/2

                 startAngle: -90
                 sweepAngle: shape.progress*360
             }
         }
         Text {
             anchors.centerIn: parent
             font{
                 pointSize: 14
                 weight: Font.DemiBold
             }

             text: (shape.progress*100).toFixed(0)+"%"
             color: "white"
         }
     }
    NumberAnimation{
        target: shape
        property: "progress"
        from: 0.0
        to:correctkey/attemptedKeys.length
        duration: 3000
        running: true
    }

    Row {
          visible: true
          spacing: parent.width/3
          anchors{
                bottom: parent.bottom
                bottomMargin: parent.height/10
                horizontalCenter: parent.horizontalCenter
            }
         Text {
                id: correct
                text: "Correct: " + `${correctkey}`
                font.bold: true
                font.pixelSize: 22
                color:"#00ff00"
             }
         Text {
                id: wrong
                text: "Wrong: " + `${wrongkey}`
                font.bold: true
                font.pixelSize: 22
                color:"#ff0000"
             }
       Text {
              id: notattempt
              text: "Not attempted: " + `${attemptedKeys.length-wrongkey-correctkey}`
              font.bold: true
              font.pixelSize: 22
              color:"#ffaa00"
             }
       }

}
