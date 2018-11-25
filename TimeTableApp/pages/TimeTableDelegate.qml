import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

ItemDelegate {
  //  property alias backgcolor: backrectangle.color
    id:itemdelg
    property var backgrdcolor: [Material.color(Material.Blue),Material.color(Material.Green),
                                Material.color(Material.BlueGrey),Material.color(Material.Brown),
                                Material.color(Material.Cyan),Material.color(Material.DeepOrange),
                                Material.color(Material.Purple),Material.color(Material.pink),
                                Material.color(Material.Indigo),Material.color(Material.Purple)]
    property var  editpop : null
    property int rowTobeUpdated: -1
    background: Rectangle{
        id:backrectangle
        color: backgrdcolor[3]
    }

    leftPadding: 5
    rightPadding: 5
    topPadding: 5
    bottomPadding: 5

  contentItem:  ColumnLayout{
      id:clyt
        //anchors.fill: parent
        spacing:5
        //anchors.margins: 10
//        implicitHeight: itemdelg.height
//        implicitWidth: itemdelg.width
       // ColumnLayout{
//            Layout.alignment: Qt.AlignLeft
//            Layout.preferredWidth: 0.6 * itemdelg.width
//            Layout.preferredHeight:itemdelg.height
            //spacing: 5
        //    clip: true
            Label {
                id:subjtext
                clip: true
                Layout.alignment: Qt.AlignLeft
                font.pointSize: 15
              //  Layout.preferredWidth: 0.6 * itemdelg.width
                //Layout.preferredHeight:itemdelg.height/2
                text:"<b><u>TASK</u></b> : " + model.taskNo+"."+model.task //+"ggafa afsdfs afsdds uiiiisis revfs ggggg"
                color: "#FFFFFF"
                //color: Material.color(Material.Grey)
                //horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                font.capitalization: Font.AllUppercase
            }
            Label {
                id:notetext
                clip: true
                Layout.alignment: Qt.AlignLeft
                font.pointSize: 12
               // Layout.preferredWidth: 0.6 * itemdelg.width
              //  Layout.preferredHeight: itemdelg.height/2 // contentHeight
                //Layout.fillHeight: true
                font.bold: false
                text:"<b><u>NOTE</u></b> : " + model.note//+"ggafa afsdfs afsdds uiiiisis revfs ggggg"
                color: Material.color(Material.Yellow)
                //horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
               // font.capitalization: Font.AllUppercase
            }
      //  }
//    ColumnLayout{
//        Layout.preferredWidth: 0.4 * itemdelg.width
//        Layout.preferredHeight: itemdelg.height
//        spacing: 5
//        clip: true
        Label {
            id:time
         //   clip: true
          //  Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            font.pointSize: 15
           // Layout.preferredWidth: 0.4 * itemdelg.width
          //  Layout.preferredHeight: itemdelg.height/2 // contentHeight
            //Layout.fillHeight: true
            Layout.alignment: Qt.AlignLeft
            font.bold: true
            text:"<b>TIME :</b>"+retText(model.fromHour,model.fromMin)+"<b> - </b>"+retText(model.toHour,model.toMin)     //+ model.fromHour+"."+model.fromMin+"<b> - </b>"+model.toHour+"."+model.toMin
             color: "#FFFFFF"
            //horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
            font.capitalization: Font.AllUppercase

            function retText(Hour,minute)
            {
                var textToprint;
                textToprint =( Hour > 12) ? (24-Hour) : Hour;
                 var amPm =( Hour > 12) ? "PM" : "AM";
                textToprint = textToprint + "."+(minute===0 ? "00":minute)+" "+amPm;
                return textToprint
            }
        }
        RowLayout{
          //  Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            //Layout.fillWidth: true
            //Layout.fillHeight: true
            Layout.alignment: Qt.AlignRight
            spacing: 2
            Layout.rightMargin: 3
            Layout.leftMargin: 3
            Layout.bottomMargin: 3

            //Layout.preferredWidth: 0.4 * itemdelg.width
            //Layout.preferredHeight: itemdelg.height/2
            ToolButton{
                id:editicon
               // Layout.preferredHeight: 40
               // Layout.preferredWidth: 40
                ToolTip.text: "edit activity"
                ToolTip.visible: pressed
                ToolTip.delay:500
                ToolTip.timeout: 1000
                opacity: pressed ? 0.75 : 1.0

                contentItem: Item {
                    implicitHeight: 24
                    implicitWidth: 24
                    Image {
                        anchors.centerIn: parent
                        source: "qrc:/images/edit.png"
                        scale: 0.75
                    }
                }
//                Image {
//                    anchors.centerIn: parent
//                    source: "qrc:/images/edit.png"
//                    scale: 0.75
//                }
                onClicked: {
                    if(editpop === null) {
                        editpop = Qt.createQmlObject("import '../popups';EditActivityPopup{}",timetablepage);
                        editpop.onClosed.connect(deleteobj)
                        rowTobeUpdated = model.taskNo
                        editpop.open()
                    }
                    function deleteobj()
                    {
                        if(editpop != null)
                            editpop.destroy()
                    }
                }
            }
            ToolButton{
                id:deleteicon
//                Layout.preferredHeight: 40
//                Layout.preferredWidth: 40
                ToolTip.text: "delete activity"
                ToolTip.visible: pressed
                ToolTip.delay:500
                ToolTip.timeout: 1000
                opacity: pressed ? 0.75 : 1.0
                contentItem: Item {
                    implicitHeight: 24
                    implicitWidth: 24
                    Image {
                        anchors.centerIn: parent
                        source: "qrc:/images/delete.png"
                        scale: 0.75
                    }
                }
//                Image {
//                    anchors.centerIn: parent
//                    source: "qrc:/images/delete.png"
//                    scale: 0.75
//                }

                onClicked: {
                    //for relational table model
                   // itemdelg.ListView.view.model.remove(index,itemdelg.ListView.view.tableName)
                   // itemdelg.ListView.view.model.setsqlquery(itemdelg.ListView.view.tableName)

                    //itemdelg.ListView.view.model.sourceModel_m.remove(model.taskNo,itemdelg.ListView.view.tableName)
                   var d= itemdelg.ListView.view.model.removeRows(index,1)
                    console.log(d)
                   // itemdelg.ListView.view.model.sourceModel_m.setsqlquery(itemdelg.ListView.view.tableName)
                }
            }

            ToolButton{
                id:reminder
                ToolTip.text: "set reminder"
                ToolTip.visible: pressed
                ToolTip.delay:500
                ToolTip.timeout: 1000
                opacity: pressed ? 0.75 : 1.0
                contentItem: Item {
                    implicitHeight: 24
                    implicitWidth: 24
                    Image {
                        id:reminderIcon
                        anchors.centerIn: parent
                        source: "qrc:/images/alarm_no_fill.png"
                        scale: 0.75
                        ToolTip.text: "reminder not set"
                        ToolTip.visible: false
                        ToolTip.delay:10
                        ToolTip.timeout: 700
                    }
                }

                onClicked: {
                    if(reminderIcon.source == "qrc:/images/alarm_no_fill.png" )
                    {
                        reminderIcon.source = "qrc:/images/alarm_fill.png"
                        reminderIcon.ToolTip.text = "reminder is set"
                        reminderIcon.ToolTip.visible = true
                    }
                    else
                    {
                        reminderIcon.source = "qrc:/images/alarm_no_fill.png"
                        reminderIcon.ToolTip.text = "reminder is not set"
                        reminderIcon.ToolTip.visible = true
                    }
                }
            }
        }

   // }

//        ColumnLayout{
//            Layout.alignment: Qt.AlignRight | Qt.AlignTop
//            Layout.fillHeight: true
//            Layout.preferredWidth:Math.max(time.contentWidth,0)
//            ToolButton {
//                id:rightMenu
//                Layout.alignment: Qt.AlignRight | Qt.AlignBottom
//                Layout.preferredHeight: 50
//                Layout.preferredWidth: 50
//                Image {
//                    id: buttonImage
//                    anchors.centerIn: parent
//                    source: "qrc:/images/rightmenu.png"
//                }
//            }
//        }
    }
}
