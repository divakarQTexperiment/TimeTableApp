import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0


Item{
//    Layout.preferredHeight: 100
//    Layout.preferredWidth: 150
//    height: 75;width: 150;
    //anchors.fill: parent
    implicitHeight: parent.height
    implicitWidth: parent.width
    //Layout.alignment: Qt.AlignHCenter  //Qt.AlignLeft | Qt.AlignTop
    //Layout.margins: 10
    property string timendate:Qt.formatDateTime(new Date(),"hh:mm:ss ap\ndd.MMM.yyyy");

    Timer {
        id: timer
        interval: 1000
        repeat: true
        running: true
        onTriggered:
        {
            timeText.text =  Qt.formatDateTime(new Date(),"hh:mm:ss ap\ndd.MMM.yyyy")
        }
    }

    ColumnLayout{
        anchors.centerIn:parent
        spacing: 5
        implicitHeight: lb1.contentHeight + timeText.contentHeight
        implicitWidth: lb1.contentWidth + timeText.contentWidth
        Label{
            id:lb1
            text:"TODAY"
            font.pointSize: 15
            //font.bold: true
            //font.underline: true
            color: "#FFFFFF"
            Layout.alignment: Qt.AlignHCenter
        }
        Label {
        id:timeText
        text :timendate
        font.pointSize: 18
        font.bold: true
        color:  "#FFFFFF"
        Layout.alignment: Qt.AlignHCenter
        }
    }

}
