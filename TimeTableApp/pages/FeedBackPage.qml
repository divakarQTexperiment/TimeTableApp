import QtQuick 2.2
import QtCharts 2.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import "../headers"
import "../toolcomps"
import QtEmailIntent 1.0

Page {
    id : feedbackpage
    header: HeaderCommon {
        toolbarcolor: Material.color(Material.Teal)
        labeltext:"FEEDBACK"
    }
    property var email: null
    property string emailBody: "emailBody"
    property string emailSubject: "feedback for app"
    property string emailId: "divakarnaik.1@hotmail.com"
    property int maxCharCout: 100


  ColumnLayout {
      id:clmlyt
    Rectangle{
        id:textframe
        Layout.preferredHeight:Math.min (feedbackpage.height / 3 , 600)
        Layout.preferredWidth:Math.min (feedbackpage.width / 1.15, 1000)
        Layout.margins: 10
        Layout.alignment: Qt.AlignTop | Qt.AlignLeft
        border.width: 1
        //opacity: 0.5
        border.color: Material.color(Material.Grey)
        clip:true
       // color: Material.color(Material.LightGreen)
        //radius: 10
        Flickable {
             id: flick
             anchors.fill: parent
             contentWidth: edit.paintedWidth
             contentHeight: edit.paintedHeight
             clip: true
             ScrollIndicator.vertical: ScrollIndicator { }

             function ensureVisible(r)
             {
                 if (contentX >= r.x)
                     contentX = r.x;
                 else if (contentX+width <= r.x+r.width)
                     contentX = r.x+r.width-width;
                 if (contentY >= r.y)
                     contentY = r.y;
                 else if (contentY+height <= r.y+r.height)
                     contentY = r.y+r.height-height;
             }

             TextEdit {
                 id: edit
                 width: flick.width
                 height: flick.height
                 focus: true
                 wrapMode: TextEdit.Wrap
                 cursorVisible:true
                 text: "Feedback"
                 font.family: "Helvetica"
                 font.pointSize: 15
                 color: "#000000"
                 //font.preferShaping:false
                 //mouseSelectionMode:TextEdit.SelectCharacters
                 //overwriteMode:true
                 //selectByMouse:true
                 //cursorPosition:text.length
                 renderType: TextEdit.NativeRendering;
                 font.hintingPreference: Font.PreferVerticalHinting
                 onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
                 property int maximumLength: 200
                 property string previousText: text

                 onTextChanged: {
                     if (text.length > maximumLength) {
                         var cursor = cursorPosition;
                         text = previousText;
                         if (cursor > text.length) {
                             cursorPosition = text.length;
                         } else {
                             cursorPosition = cursor-1;
                         }
                     }
                     previousText = text
                     emailBody = edit.text
                 }


             }
         }
    }
    ButtonFlat {
        id: okButton
        text: qsTr("SEND")
        textColor: "#FFFFFF"
        ToolTip.text:"submitted"
        Layout.alignment: Qt.AlignRight
        ToolTip.delay: 10
        ToolTip.timeout: 10
       // Layout.preferredHeight: 50
        Layout.margins: 10
        Layout.preferredWidth: Math.min(feedbackpage.width/1.5,120)
        Layout.fillWidth: false
        onClicked: {
            if(email === null)
            {
                email = Qt.createQmlObject("import QtEmailIntent 1.0;EmailIntent{ } ",feedbackpage);

                email.email(emailBody,emailSubject,emailId);
               // email.destroy()
            }
            else
            {
               console.log("email already exists")
               email.email(emailBody,emailSubject,emailId);
            }
        }
    }
  }
}
