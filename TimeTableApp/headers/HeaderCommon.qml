import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtQuick.Window 2.3
import QtQuick.Dialogs 1.3
import "../toolcomps"

ToolBar {
    id:toolbaroptions
    //focus: true
    property string toolbarcolor: Material.color(Material.Teal)
    property string labeltext:qsTr("home")
    property string source1:qsTr("qrc:/images/back.png")
    implicitHeight: 50

    background: Rectangle {
    anchors.fill: parent
    color: toolbarcolor
    }

    ToolButton{
        id:gotohome
        focus: true
        height: 40
        width: 40
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        Image {
            anchors.centerIn:parent
            source: source1
        }
        MouseArea{
            id:ma1
            anchors.fill: parent
            onClicked:
            {
                stackView.pop()
            }
        }
    }

    Label{
        id:optionlabel
        anchors.centerIn: parent
        text:labeltext
        font.pointSize: 15
        font.bold: true
        //color: Material.color(Material.Indigo)
    }

}

