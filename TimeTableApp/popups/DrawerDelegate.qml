import QtQuick 2.0
import QtQuick.Layouts 1.3
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


ItemDelegate {
    id:delegateItem
    width:  parent.width
    height: coln.height
    ColumnLayout {
        id:coln
       // anchors.fill: parent
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top:parent.top
        RowLayout {
            id:drawerdelegate
             spacing: 6
            Layout.alignment: Qt.AlignLeft
            Item {
                Layout.preferredHeight: 40
                Layout.preferredWidth: 40
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.margins: 5
                Image {
                    id: icon
                    source: Qt.resolvedUrl(model.source)
                    anchors.centerIn: parent
                }
            }

            Label {
                id:iconname
                text: name
                font.pointSize: 12
                Layout.alignment: Qt.AlignVCenter
                Layout.margins: 5
            }
        }

        HorizontalDivider {
            Layout.preferredWidth: parent.width
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            Layout.alignment: Qt.AlignBottom

        }
    }

    onClicked: {
        drawerview.currentIndex= index
       // if(name !== qsTr("Home"))
        //{
//            messageDialog.pagetoload=pagetoload
//            optionheading= name;
//            messageDialog.open()
            stackView.push(pagetoload)

            drawerhome.close()
            console.log("DrawerDelegate : loaded a page ",pagetoload)
        //}
    }

}
