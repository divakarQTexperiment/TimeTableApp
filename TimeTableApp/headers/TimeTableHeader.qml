import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.2
import QtQuick.Window 2.3
import QtQuick.Dialogs 1.3
import "../toolcomps"
import "../popups"
//import "../jsfiles/CreateObjectDynamic.js" as Createobj


ColumnLayout{
    implicitHeight: toolbaroptions.implicitHeight +tbbar.implicitHeight
    implicitWidth: parent.width
    spacing: 0
    property var tabbarmodel: [{name:"mon"},{name:"tue"},{name:"wed"},{name:"thu"},
                              {name:"fri"},{name:"sat"},{name:"sun"}]
    property alias dayTabCurrentindex: tbbar.currentIndex
    property var showtime: null

ToolBar {
    id:toolbaroptions
    //focus: true
    Layout.alignment: Qt.AlignTop
    implicitHeight: 50
    implicitWidth: parent.width

    property var tabbarmodel: [{name:"mon"},{name:"tue"},{name:"wed"},{name:"thu"},
                              {name:"fri"},{name:"sat"},{name:"sun"}]

    background: Rectangle {
    //anchors.fill: parent
    color: Material.color(Material.Teal)
    }

  contentItem: RowLayout{
       // anchors.fill: parent
        spacing:6
        ToolButton {
            id:gotohome
            focus: true
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Image {
                anchors.centerIn:parent
                source: "qrc:/images/back.png"
            }
            onClicked: {
                stackView.pop()
            }
        }

        Label{
            id:optionlabel
            Layout.alignment: Qt.AlignHCenter
//            Layout.preferredWidth: 100
//            Layout.preferredHeight: 50
            Layout.fillHeight: true
            Layout.fillWidth: true
            Text{
                text:qsTr("TIME TABLE")
                font.pointSize: 15
                font.bold: true
                color: "#0FFFFF"
                anchors.centerIn: parent
            }
        }

        ToolButton {
            id:currenttime
            focus: true
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            ToolTip.text: "Time and Date"
            ToolTip.visible: pressed
            ToolTip.timeout: 1000
            ToolTip.delay: 1000
            Image {
                anchors.centerIn:parent
                source: "qrc:/images/currentTime.png"
            }
            onClicked: {
//                if(showtime == null) {
//                    Createobj.createObjects("qrc:/toolcomps/PopupTimeDate.qml",timetablepage)
//                    showtime = Createobj.obj
//                    if(showtime !== null) {
//                       console.log("showtime was null,now created and opening it..")
//                       showtime.open()
//                    }
//                    else
//                    {
//                      console.log(" TimeTableHeader : showtime object creation failure !!",showtime)
//                    }
//                }
//                else {
//                    console.log("showtime already created just opening it..")
//                    showtime.open()
//                }


                if(showtime === null)
                {
                    //Qt.createQmlObject("EditActivityPopup{}",itemdelg);
                    showtime = Qt.createQmlObject("import '../popups';PopupTimeDate{ }",timetablepage);
                    showtime.onClosed.connect(deleteobj)
                    showtime.open()
                }
                function deleteobj()
                {
                    if(showtime != null)
                        showtime.destroy()
                }
            }
        }

//        ToolButton {
//            id:extend
//            focus: true
//            Layout.preferredHeight: 40
//            Layout.preferredWidth: 40
//            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
//            ToolTip.text: "Add activity"
//            ToolTip.visible: pressed
//            ToolTip.timeout: 1000
//            ToolTip.delay: 1000
//            Image {
//                anchors.centerIn:parent
//                source: "qrc:/images/extend.png"
//            }
//        }
    }
}

TabBar {
        id:tbbar
        Layout.alignment: Qt.AlignTop
        implicitWidth: parent.width
        background: Rectangle{
            color: Material.color(Material.Indigo)
        }

        Material.accent: Material.color(Material.DeepOrange)
        Material.elevation: 10
        currentIndex: swpview.currentIndex
        Repeater{
            model: tabbarmodel
            TabButton{
                leftPadding: 6
                rightPadding: 6
               // implicitWidth:150
                // width: timetablepage.width < implicitWidth*7
                 width: Math.max(150, tbbar.width / 7)
                contentItem:
                    ColumnLayout{
                        Text{
                        text:qsTr(modelData.name)
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        font.pointSize: 12
                        font.bold: true
                        color: "#FFFFFF"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        font.capitalization: Font.AllUppercase
                        font.weight: Font.Medium
                    }
                }
               opacity: pressed|checked ? 0.5 : 1.0
            }
        }
    }
}


