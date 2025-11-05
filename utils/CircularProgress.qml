import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {
    id: root

    property real progress: 0.0  // 0.0 to 1.0
    property int size: 100
    property int lineWidth: 8
    property color primaryColor: "#6fda00"
    property color backgroundColor: "#2a2a2a"
    property string centerText: ""
    property int centerTextSize: 24
    property bool showPercentage: true

    width: size
    height: size

    // Background circle
    Shape {
        anchors.fill: parent

        ShapePath {
            fillColor: "transparent"
            strokeColor: root.backgroundColor
            strokeWidth: root.lineWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: (root.width - root.lineWidth) / 2
                radiusY: (root.height - root.lineWidth) / 2
                startAngle: 0
                sweepAngle: 360
            }
        }
    }

    // Progress arc
    Shape {
        anchors.fill: parent

        ShapePath {
            fillColor: "transparent"
            strokeColor: root.primaryColor
            strokeWidth: root.lineWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: (root.width - root.lineWidth) / 2
                radiusY: (root.height - root.lineWidth) / 2
                startAngle: -90  // Start from top
                sweepAngle: Math.min(360 * root.progress, 360)
            }
        }
    }

    // Center text
    Text {
        anchors.centerIn: parent
        text: root.centerText !== "" ? root.centerText :
              (root.showPercentage ? Math.round(root.progress * 100) + "%" : "")
        font.pixelSize: root.centerTextSize
        font.bold: true
        color: root.primaryColor
    }

    // Smooth animation
    Behavior on progress {
        NumberAnimation {
            duration: 500
            easing.type: Easing.OutCubic
        }
    }
}
