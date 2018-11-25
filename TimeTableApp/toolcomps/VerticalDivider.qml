import QtQuick 2.0
import QtQuick.Controls.Material 2.2

Item {
    height: parent.height
    width: 2
    Rectangle {
        width: 1
        anchors.verticalCenter : parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height
        opacity: 0.5
        color: Material.color(Material.Grey)
    }
}
