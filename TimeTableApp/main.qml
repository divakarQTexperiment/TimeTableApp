import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import "pages"
import sqlfilter.custom 1.0

ApplicationWindow {
    id:mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Time Table 1.0")

    property bool themeColor: false
    Material.theme: themeColor ? Material.Dark:Material.Light

    StackView {
        id: stackView
       initialItem: "qrc:/pages/HomePage.qml"
       anchors.fill: parent
    }
}
