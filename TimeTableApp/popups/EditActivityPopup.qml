import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Controls.Styles 1.4
import "../toolcomps"

Popup {
    id:editactivity
    focus: true
    modal: true
    dim: true
    x: parent.width/2-width/2
    y:parent.height/2-height/2
    Material.elevation: 8
    width :Math.min(parent.width / 1.25 , 400)
    height: Math.min(parent.height / 1.25 ,400 ) //layout.implicitHeight+50
    property var fromTime: null
    property var toTime: null
    property alias tasktext: tasktextfiled.text
    property alias notetext: notetextfiled.text
    property alias fromtimevalue: fromTimeTextField.text
    property alias totimevalue: toTimeTextField.text
    property var varList: [0,"task","note",0,0,0,0]
    property int fromHoursIntVal:-1;
    property int fromMinsIntVal:-1;
    property int toHoursIntVal:-1;
    property int toMinsIntVal:-1;
    property color backRectBordColor: Material.color(Material.Grey)
    property color backRectBordHighlight: Material.color(Material.DeepOrange)

    Pane{
        anchors.fill: parent
        Flickable {
            id:flickarea
            anchors.fill: parent
            //contentHeight: layout.height
            clip: true
           // contentWidth: contentItem.childrenRect.width;
            contentHeight: contentItem.childrenRect.height

            ColumnLayout {
                id:layout
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.right: parent.right
                spacing:10
                RowLayout{
                    Layout.preferredWidth: editactivity.width
                    //Layout.preferredHeight:parent.height
                    Layout.alignment: Qt.AlignRight
                    spacing: 3
                    Label{
                        Layout.alignment: Qt.AlignHCenter
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text:"EDIT ACTIVITY"
                        color: Material.color(Material.DeepOrange)
                        font.bold: true
                        font.pointSize: 15
                        horizontalAlignment:Text.AlignHCenter
                        verticalAlignment:TextInput.AlignVCenter

                        font.underline: true
                    }

                    ToolButton{
                        id:deleteicon
                        Layout.preferredHeight: 50
                        Layout.preferredWidth: 50
                        ToolTip.text: "close"
                        ToolTip.visible: pressed
                        ToolTip.delay:500
                        ToolTip.timeout: 1000
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Image {
                            anchors.centerIn: parent
                            source: "qrc:/images/close.png"
                        }
                        onClicked: {
                            editactivity.close()
                        }
                    }
                }
//                HorizontalDivider{
//                    Layout.fillWidth: true
//                    Layout.preferredWidth: parent.width

//                }
                TextField{
                    id:tasktextfiled
                    Layout.alignment:  Qt.AlignBottom
                    placeholderText: qsTr("task: (ex:subject to study)")
                    //text : ""
                    //implicitWidth: 300
                    Layout.preferredWidth: parent.width  //Math.min(userinfopage.width-txt.width,200)
                    color: Material.color(Material.Indigo)
                    focus: true
                    activeFocusOnPress:true
                    echoMode:TextInput.Normal
                    horizontalAlignment:Text.AlignLeft
                    verticalAlignment:TextInput.AlignBottom
                    font.pointSize: 15
                    maximumLength:100
                    selectByMouse:true
                    readOnly:false
                    property alias backColor: backrect.border
                    background: Rectangle {
                        id:backrect
                        radius: 5
                        implicitWidth: 100
                        implicitHeight: 24
                        border.color: backRectBordColor
                        border.width: 1
                   }
                    onTextEdited:{
                        if(tasktextfiled.text == "")
                        {
                           tasktextfiled.backColor.color = backRectBordHighlight
                        }
                        else
                        {
                            tasktextfiled.backColor.color = backRectBordColor
                        }
                    }
                }
                TextField{
                    id:notetextfiled
                    Layout.alignment:  Qt.AlignBottom
                    placeholderText: qsTr("Note : (ex: author name)")
                    //text : name2
                    //implicitWidth: 300
                    Layout.preferredWidth: parent.width  //Math.min(userinfopage.width-txt.width,200)
                    color: Material.color(Material.Indigo)
                    focus: true
                    activeFocusOnPress:true
                    echoMode:TextInput.Normal
                    horizontalAlignment:Text.AlignLeft
                    verticalAlignment:TextInput.AlignBottom
                    font.pointSize: 15
                    maximumLength:100
                    selectByMouse:true
                    readOnly:false
                    property alias backColor: backrect2.border
                    background: Rectangle {
                        id:backrect2
                        radius: 5
                        implicitWidth: 100
                        implicitHeight: 24
                        border.color: backRectBordColor
                        border.width: 1
                   }
                    onTextEdited:{
                        if(notetextfiled.text == "")
                        {
                           notetextfiled.backColor.color = backRectBordHighlight
                        }
                        else
                        {
                            notetextfiled.backColor.color = backRectBordColor
                        }
                    }
                }

                TextField{
                    id:fromTimeTextField
                    Layout.alignment:  Qt.AlignBottom
                    placeholderText: qsTr("From Time")
                    text : ""
                    Layout.preferredWidth: parent.width  //Math.min(userinfopage.width-txt.width,200)
                    color: Material.color(Material.Indigo)
                    focus: true
                    activeFocusOnPress:true
                    echoMode:TextInput.Normal
                    horizontalAlignment:Text.AlignLeft
                    verticalAlignment:TextInput.AlignBottom
                    font.pointSize: 15
                    maximumLength:100
                    selectByMouse:true
                    readOnly:true
                    property alias backColor: backrect3.border
                    background: Rectangle {
                        id:backrect3
                        radius: 5
                        implicitWidth: 100
                        implicitHeight: 24
                        border.color: backRectBordColor
                        border.width: 1
                   }
                    onTextChanged:{
                        if(fromTimeTextField.text == "")
                        {
                           fromTimeTextField.backColor.color = backRectBordHighlight
                        }
                        else
                        {
                            fromTimeTextField.backColor.color = backRectBordColor
                        }
                    }
                    onPressed: {
                        if(fromTime === null) {
                            fromTime = Qt.createQmlObject("TimePicker{}",timetablepage);
                            fromTime.onClosed.connect(deleteobj)
                            fromTime.open()
                        }
                        function deleteobj()
                        {
                            if(fromTime != null)
                            {
                               // fromtimevalue = fromTime.timevalue
                                text = fromTime.timevalue
                                fromHoursIntVal = fromTime.hourInInt
                                fromMinsIntVal = fromTime.minInInt
                                fromTime.destroy()
                            }
                        }
                    }
                }




                TextField{
                    id:toTimeTextField
                    Layout.alignment:  Qt.AlignBottom
                    placeholderText: qsTr("To Time")
                    text : ""
                    Layout.preferredWidth: parent.width  //Math.min(userinfopage.width-txt.width,200)
                    color: Material.color(Material.Indigo)
                    focus: true
                    activeFocusOnPress:true
                    echoMode:TextInput.Normal
                    horizontalAlignment:Text.AlignLeft
                    verticalAlignment:TextInput.AlignBottom
                    font.pointSize: 15
                    maximumLength:100
                    selectByMouse:true
                    readOnly:true
                    property alias backColor: backrect4.border
                    background: Rectangle {
                        id:backrect4
                        radius: 5
                        implicitWidth: 100
                        implicitHeight: 24
                        border.color: backRectBordColor
                        border.width: 1
                   }
                    onTextChanged:{
                        if(toTimeTextField.text == "")
                        {
                           toTimeTextField.backColor.color = backRectBordHighlight
                        }
                        else
                        {
                            toTimeTextField.backColor.color = backRectBordColor
                        }
                    }
                    onPressed: {
                        if(toTime === null) {
                            toTime = Qt.createQmlObject("TimePicker{}",timetablepage);
                            toTime.onClosed.connect(deleteobj)
                            toTime.open()
                        }
                        function deleteobj()
                        {
                            if(toTime != null)
                            {
                              //  totimevalue = toTime.timevalue
                                text = toTime.timevalue
                                toHoursIntVal = toTime.hourInInt
                                toMinsIntVal = toTime.minInInt
                                toTime.destroy()
                            }
                        }
                    }
                }

                ButtonFlat {
                    id: okButton
                    text: qsTr("SAVE")
                    textColor: "#FFFFFF"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                    Layout.fillWidth: true
                    ToolTip.text:"submitted"
                    ToolTip.delay: 10
                    ToolTip.timeout: 1500
                    onClicked: {
                        if((tasktext == "") ||(notetext == "") || (fromtimevalue == "") || (totimevalue == ""))
                        {
                            if(ToolTip.visible === false)
                            {
                                console.log(itemdelg.rowTobeUpdated)
                                ToolTip.text="fill all fields"
                                ToolTip.visible=true
                            }
                            if(tasktext == "")
                                tasktextfiled.backColor.color = backRectBordHighlight
                            if(notetext == "")
                               notetextfiled.backColor.color = backRectBordHighlight
                            if(fromtimevalue == "")
                              fromTimeTextField.backColor.color = backRectBordHighlight
                            if(totimevalue == "")
                              toTimeTextField.backColor.color = backRectBordHighlight
                        }
                        else
                        {
                            varList[0] = itemdelg.rowTobeUpdated
                            varList[1]  = tasktext
                            varList[2] = notetext
                            varList[3] = fromHoursIntVal
                            varList[4] = fromMinsIntVal
                            varList[5] = toHoursIntVal
                            varList[6] = toMinsIntVal
                            console.log(varList)

                           var  writeEditDataObj = Qt.createQmlObject("import TimeTableModel.custom 1.0;QLSqlTimeTableModel{}",timetablepage);
                           if(writeEditDataObj.setDbData(itemdelg.ListView.view.tableName,
                            itemdelg.rowTobeUpdated, varList))
                           {
                               if(ToolTip.visible === false)
                               {
                                   ToolTip.text="submiited"
                                  ToolTip.visible=true
                               }
                           }
                           writeEditDataObj.destroy()
                       }

                    }
                }





            }
        }
    }

    Component.onCompleted: {
        console.log("EditActivityPopup created")
    }
    Component.onDestruction: {
        console.log("EditActivityPopup Destroyed")
    }
}

