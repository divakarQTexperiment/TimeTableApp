import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import "../popups"
import "../headers"
import "../pages"
import "../toolcomps"

Popup {
    id: popup
    Material.elevation: 8
    x: parent.width/2-width/2
    y:parent.height/2-height/2
    modal: true
    dim: true
    property int fontsize: 13

    width :Math.min(parent.width / 1.5 , 400)
    height: Math.min(parent.height / 2 , theContent.implicitHeight+50)

    Pane{
     anchors.fill: parent
        Flickable {
            id:flick
             anchors.fill: parent
             clip: true
            //contentWidth: theContent.width
            contentHeight: theContent.height
            ColumnLayout {
                id: theContent
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
                spacing: 3
                RowLayout{
                    //Layout.alignment: Qt.AlignHCenter
                   // Layout.fillWidth: true
                    //implicitWidth: popup.width
                    //implicitHeight: popupclose.implicitHeight
                    Layout.preferredWidth: parent.width
                    Layout.fillWidth: true
                    Layout.preferredHeight: popupclose.implicitHeight
                    spacing: 0
                    Label {
                        id:labeltext
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                        text: qsTr("Settings")
                        font.pointSize: fontsize
                        font.bold: true
                        color: Material.color(Material.Orange)
                    }
                    ToolButton{
                        id:popupclose
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                        implicitHeight: 40
                        implicitWidth: 40
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
                        Image {
                            anchors.centerIn: parent
                            source: "qrc:/images/close.png"
                        }
                        onClicked: {
                            popup.close()
                        }
                    }
                }
                HorizontalDivider {
                    id:divider
                    Layout.preferredWidth: parent.width
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    Layout.alignment: Qt.AlignBottom
                }
                Switch {
                    id: themeswitch
                    Layout.alignment: Qt.AlignLeft
                    topPadding: 6
                    leftPadding: 12
                    text: qsTr("Light Theme")
                    font.pointSize: mainWindow.fontsize1-3
                    checked: mainWindow.themeColor
                    onCheckedChanged: {
                       if(checked === false)
                       {
                           text = qsTr("Light Theme")
                           mainWindow.themeColor = false
                       }
                       else
                       {
                           text = qsTr("Dark Theme")
                           mainWindow.themeColor = true
                       }

                    }
                }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
  }

} // popup
