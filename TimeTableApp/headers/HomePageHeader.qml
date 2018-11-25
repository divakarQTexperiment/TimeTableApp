import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import "../popups"
import "../headers"
import "../pages"
import "../toolcomps"
import "../js_files/CreateObjectDynamic.js" as Createobj

ToolBar {
    id:hometoolbar

    property color toolbarcolor: Material.color(Material.Purple)
    Material.accent: Material.color(Material.Pink)
    property var drawerhome: null
    property var rightmenupopup: null
    //property alias optionmenustate: optionopen.state
    implicitHeight: 60

    background: Rectangle {
    anchors.fill: parent
    color: toolbarcolor
    }

    RowLayout {
        anchors.fill: parent
        spacing : 6
        ToolButton {
            id:optionopen
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Layout.preferredHeight: 50
            Layout.preferredWidth: 50
            Image {
                id : optionopenicon
                anchors.centerIn:parent
                source: "qrc:/images/menu.png"
            }

            onClicked: {
//                if(drawerhome === null)
//                {

//                    drawerhome = Qt.createQmlObject(" import '../popups' ; DrawerHome{ }",homepage);
//                    drawerhome.onClosed.connect(deleteobj)
//                    drawerhome.open()
//                }
//                function deleteobj()
//                {
//                    if(drawerhome != null)
//                        drawerhome.destroy()
//                }
                if(drawerhome == null)
                {
                    Createobj.createObjects("qrc:/popups/DrawerHome.qml",homepage)
                    drawerhome = Createobj.obj

                    if(drawerhome !== null)
                    {
                        drawerhome.x = ( parent.x+parent.width-width)
                        drawerhome.y = (parent.y)
                        //console.log("drawerhome was null,now created and opening it..")
                        drawerhome.open()
                    }

                    else
                    {
                        console.log(" drawerhome : drawerhome object creation failure !!",drawerhome)
                    }
                }

                else
                {
                    //console.log("drawerhome already created just opening it..")
                    drawerhome.open()
                }
            }
        }

        Label{
            id: labelhome
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Layout.preferredHeight: 50
            Layout.preferredWidth: 50
            Layout.fillWidth: true
            Text {
                text: qsTr("TIMETABLE 1.0")
                anchors.centerIn: parent
                font.pointSize: 15
                font.bold: true
                color: "white"
            }
        }

        ToolButton {
            id:rightMenu
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Layout.preferredHeight: 50
            Layout.preferredWidth: 50
            Image {
                id: buttonImage
                anchors.centerIn: parent
                source: "qrc:/images/rightmenu.png"
            }
            onClicked: {
                if(rightmenupopup == null)
                {
                    Createobj.createObjects("qrc:/popups/RightMenuPopup.qml",rightMenu)
                    rightmenupopup = Createobj.obj

                    if(rightmenupopup !== null)
                    {
                        rightmenupopup.x = ( parent.x+parent.width-width)
                        rightmenupopup.y = (parent.y)
                       // console.log("rightmenupopup was null,now created and opening it..")
                        rightmenupopup.open()
                    }

                    else
                    {
                        console.log(" rightmenupopup : rightmenupopup object creation failure !!",rightmenupopup)
                    }
                }

                else
                {
                   // console.log("rightmenupopup already created just opening it..")
                    rightmenupopup.open()
                }
            }
        }
}
}

