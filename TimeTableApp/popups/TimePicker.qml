import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import "../toolcomps"

Popup {
    id:timePickerPopup

    x: parent.width/2-width/2
    y:parent.height/2-height/2
//    width :Math.min(parent.width / 2, 300)
//    height: Math.min(parent.height / 2 , 300)
    width :Math.min(parent.width / 1.25 , 400)
    height: Math.min(parent.height / 1.25 ,400 ) //layout.implicitHeight+50

    property string timevalue:"0"
    property int hourInInt: -1
    property int minInInt: -1

    property var ampmmodel:  ["AM", "PM"]

    Material.elevation: 8
    focus: true
    modal: true
    dim: true

    //background: Rectangle{color: Material.color(Material.Orange); radius: width/2 }

    function formatText(count, modelData) {
        var data = count === 12 ? modelData + 1 : modelData;
        return data.toString().length < 2 ? "0" + data : data;
    }

    FontMetrics {
        id: fontMetrics
    }

    Component {
        id: hourdelegate
        TextInput {
            text: timePickerPopup.formatText(Tumbler.tumbler.count, modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            readOnly: (Tumbler.tumbler.currentIndex === index ) ? false:true
            font.pointSize:(Tumbler.tumbler.currentIndex === index) ? 18 : 12
            font.capitalization :Font.AllUppercase
            font.bold :(Tumbler.tumbler.currentIndex === index) ? true : false
            wrapMode:TextInput.WordWrap
            validator: IntValidator{bottom: 1; top: 12;}
            signal changeTumbIndex(int indx)
            onAccepted: {
                var kk = parseInt(text)-1;
                changeTumbIndex(kk)
            }
            Component.onCompleted: {
                changeTumbIndex.connect(Tumbler.tumbler.changeIndex)
            }
        }
    }

    Component {
        id: minutedelegate
        TextInput {
            text: timePickerPopup.formatText(Tumbler.tumbler.count, modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            readOnly: (Tumbler.tumbler.currentIndex === index ) ? false:true
            font.pointSize:(Tumbler.tumbler.currentIndex === index) ? 18 : 12
            font.capitalization :Font.AllUppercase
            font.bold :(Tumbler.tumbler.currentIndex === index) ? true : false
            wrapMode:TextInput.WordWrap
            validator: IntValidator{bottom: 0; top: 59;}
            signal changeTumbIndex(int indx)
            onAccepted: {
                var kk = parseInt(text);
                //text = timePickerPopup.formatText(Tumbler.tumbler.count, modelData)
                changeTumbIndex(kk)
            }
            Component.onCompleted: {
                changeTumbIndex.connect(Tumbler.tumbler.changeIndex)
            }

        }
    }

    Component {
        id: ampmdelegate
        Label {
            text: timePickerPopup.formatText(Tumbler.tumbler.count, modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize:(Tumbler.tumbler.currentIndex === index) ? 18 : 12
            font.capitalization :Font.AllUppercase
            font.bold :(Tumbler.tumbler.currentIndex === index) ? true : false
            wrapMode:TextInput.WordWrap
        }
    }
    Pane{
        anchors.fill: parent
        Flickable {
            id:flickarea
            anchors.fill: parent
            //contentHeight: layout.height
            clip: true
           // contentWidth: contentItem.childrenRect.width;
            contentHeight: contentItem.childrenRect.height
  /*contentItem:*/ColumnLayout{
       // anchors.centerIn: parent
       // anchors.margins: 5
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
       // anchors.bottom: parent.bottom
        spacing:10
        RowLayout {
            id: row
            Layout.alignment: Qt.AlignHCenter
            spacing: 5
            Tumbler {
                id: hoursTumbler
                property string val:"0"
                model: 12
                visibleItemCount:5
                property var prevItem: null
                property string prevText: ""
                signal changeIndex(int indx)
                delegate: hourdelegate
                onCurrentIndexChanged: {
                    val = currentItem.text
                    if(prevItem != null)
                    {
                     prevItem.text  =prevText
                    }
                    prevItem = currentItem
                    prevText = currentItem.text
                }
                onChangeIndex: {
                    console.log("changing index to "+indx)
                    currentIndex = indx;
                }
            }

            Tumbler {
                id: minutesTumbler
                property string val:"0"
                model: 60
                visibleItemCount:5
                property var prevItem: null
                property string prevText: ""
                delegate: minutedelegate
                signal changeIndex(int indx)
                onCurrentIndexChanged: {
                    val = currentItem.text
                    if(prevItem != null)
                    {
                     prevItem.text  =prevText
                    }
                    prevItem = currentItem
                    prevText = currentItem.text
                }
                onChangeIndex: {
                    console.log("changing index to "+indx)
                    currentIndex = indx;
                }
            }

            Tumbler {
                id: amPmTumbler
                property string val:"0"
                model:ampmmodel
                visibleItemCount:3
                delegate: ampmdelegate
                onCurrentIndexChanged: {
                    console.log(currentItem.text)
                    val = currentItem.text
                    console.log(currentIndex)
                }
            }
        }
        ButtonFlat {
            id: okButton
            text: qsTr("OK")
            textColor: "#FFFFFF"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            onClicked: {
                timevalue = hoursTumbler.val+ "." + minutesTumbler.val+ amPmTumbler.val
                if(amPmTumbler.val === "AM")
                {
                    hourInInt =  parseInt(hoursTumbler.val)
                }
                else if(amPmTumbler.val === "PM")
                {
                     hourInInt =  parseInt(hoursTumbler.val)
                     hourInInt = hourInInt + 12;
                }
                else
                {

                }
                minInInt = parseInt(minutesTumbler.val)
                console.log("in int"+hourInInt+":"+minInInt)
                timePickerPopup.close()
            }
        }
    }
        }
    }

    Component.onCompleted: {
        console.log("Timepicker created")
    }
    Component.onDestruction: {
        console.log("Timepicker Destroyed")
    }

    onClosed: {

    }
}
