import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtQuick.Window 2.3
import QtQuick.Dialogs 1.3
import "../popups"
import "../headers"
import "../pages"
import "../toolcomps"

Drawer {
    id: drawer

    width: mainWindow.width * 0.80
    height: mainWindow.height
    dragMargin:0
    edge:Qt.LeftEdge
    DrawerView {
        id : drawerview
        anchors.fill: parent
    }
}
