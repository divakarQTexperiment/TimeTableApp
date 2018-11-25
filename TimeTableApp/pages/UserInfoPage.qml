import QtQuick 2.2
import QtCharts 2.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import "../headers"
import "../toolcomps"

Page {
    id:userinfopage
    property int fontsize: 15
    property color color1: (mainWindow.themeColor === false) ? Material.color(Material.Orange):Material.color(Material.Teal)
    property color color2: (mainWindow.themeColor === false) ? Material.color(Material.blue):Material.color(Material.Yellow)
    property color labelheader: Material.color(Material.Cyan)
    Material.accent: (mainWindow.themeColor === false) ? Material.color(Material.pink):Material.color(Material.Light)
    property var responsestr:["","","","","",""]

    ListModel {
     id:userModel
     ListElement{ name1 : "NAME";name2:"";placeholder:"enter name" }
     ListElement{name1 : "AGE";name2:"";placeholder:"enter age"}
     ListElement{name1 : "CITY";name2:"";placeholder:"enter city"}
     ListElement{name1 : "PHONE";name2:"";placeholder:"enter phone"}
     ListElement{name1 : "EMAIL ID";name2:"";placeholder:"enter email"}
     ListElement{name1 : "EDUCATION";name2:"";placeholder:"enter education"}
    }


    header: HeaderCommon {
        id:header
        toolbarcolor: Material.color(Material.Teal)
        labeltext:qsTr("USER")
    }


    Flickable{
        anchors.fill: parent
        contentHeight: parentlyt.height
        //contentWidth: parentlyt.width
        clip: true

    ColumnLayout {
        id:parentlyt
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top:parent.top
        spacing: 10
        Label{
            id: heading
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 5
            text: qsTr("USER INFORMATION")
            color: labelheader
            font.pointSize: fontsize
            font.bold: true
        }

        Item {
            id:usericon
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            Layout.alignment: Qt.AlignHCenter
            //radius: width/2
           // Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            // Layout.margins: 5
            // color: "#FFFFFF"
            Image {
                anchors.centerIn: parent
                source: Qt.resolvedUrl("qrc:/images/user48.png")
               // source: Qt.resolvedUrl("qrc:/images/black/drawer/user64.png")
            }
        }

        Repeater {
           //model: repeaterdata
            model:userModel
           //model:userInfo
        RowLayout {
            parent: parentlyt
        Layout.alignment: Qt.AlignHCenter
        //Layout.preferredWidth: parent.width
       // Layout.fillWidth: true
       // Layout.margins: 2
        spacing: 0
            Label {
                id:txt
                Layout.preferredWidth:100
//                Layout.margins: 2
                 Layout.alignment:  Qt.AlignVCenter
                text: qsTr(name1)
                color: color1
                font.pointSize: fontsize-3
                font.bold: true
            }

        TextField {
            Layout.alignment:  Qt.AlignBottom
            placeholderText: qsTr(placeholder)
            text : name2 //userInfo.userinfo[index]   //qsTr(strlist[index])
            //implicitWidth: 300
            Layout.preferredWidth: Math.min(userinfopage.width-txt.width,200)
            //Layout.margins: 2
            color: color2
            //implicitHeight: 10
            focus: true
            activeFocusOnPress:true
            echoMode:TextInput.Normal
            horizontalAlignment:Text.AlignLeft
            verticalAlignment:TextInput.AlignBottom
            font.pointSize: fontsize-3
            maximumLength:100
            selectByMouse:true
            readOnly:false
            //inputMask: '>A'
            //validator: IntValidator {bottom: 11; top: 31;}
            onTextChanged: {
               // console.log(text)
               responsestr[index] = text;
               // console.log("Settings : "+responsestr)
            }

            onEditingFinished: {
//                console.log(text)
//               responsestr[index] = text;
//                console.log(responsestr)
            }
        }
        }


    }
        ButtonFlat {
            id: okButton
            text: qsTr("SUBMIT")
            textColor: "#FFFFFF"
            ToolTip.text:"submitted"
            Layout.alignment: Qt.AlignHCenter
            ToolTip.delay: 10
            ToolTip.timeout: 10
           // Layout.preferredHeight: 50
            Layout.margins: 5
            Layout.preferredWidth: Math.min(userinfopage.width/1.5,150)
            Layout.fillWidth: false

            onClicked: {
             //writeToDb.fill_user_info(responsestr);
               if(userInfo.fill_user_info(responsestr))
               {
                   if(ToolTip.visible === false)
                      ToolTip.visible=true

                   var i=0
                   for(i=0;i<userModel.count;i++)
                   userModel.setProperty(i, "name2", responsestr[i])
               }
            }
        }
    }
}

    Component.onCompleted: {

        if(userInfo.return_userinfo()) {
        var i=0
        for(i=0;i<userModel.count;i++)
        userModel.setProperty(i, "name2", userInfo.userinfo[i])
        console.log(userInfo.userinfo[i])
        }
    }
}


