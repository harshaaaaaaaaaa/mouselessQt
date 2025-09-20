import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Shapes
import QtQuick.Controls 2.15

Rectangle{
     id:root
     anchors.fill: parent
     color:"black"
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

    Component.onCompleted: updateKeyCounts()
    onAttemptedKeysChanged: updateKeyCounts()

    Button {
        id: backButton
        text: "Back"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        onClicked: stackView.pop()
    }

    Row {
          visible: true
          spacing: parent.width/2
          anchors{
                 top: parent.top
                 topMargin: parent.height/10
                horizontalCenter: parent.horizontalCenter
            }
         Text {
                id: score
                text: "Score : " + `${4*correctkey-wrongkey}/${4*attemptedKeys.length}`
                font.bold: true
                font.pixelSize: 35
                color:"white"
             }
         Rectangle{
                  id:keyAnalysis
                  height:50
                  width:100
                  radius: 5
                  color:"yellow"
           Text {
                anchors.centerIn: parent
                id: mark
                text: "Key Analysis"
                font.bold: true
                font.pixelSize: 16
                color:"red"
             }
           MouseArea {
               anchors.fill: parent
               onClicked: {
                   stackView.push("KeyAnalysis.qml", {
                      attemptedKeys:attemptedKeys,
                       appsdata:appsdata,
                       stackView: stackView
                   })
               }
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
                text: "Correct:" + `${correctkey}`
                font.bold: true
                font.pixelSize: 25
                color:"green"
             }
         Text {
                id: wrong
                text: "Wrong:" + `${wrongkey}`
                font.bold: true
                font.pixelSize: 25
                color:"red"
             }
       Text {
              id: notattempt
              text: "Notattempt:" + `${attemptedKeys.length-wrongkey-correctkey}`
              font.bold: true
              font.pixelSize: 25
              color:"yellow"
             }
       }

}


