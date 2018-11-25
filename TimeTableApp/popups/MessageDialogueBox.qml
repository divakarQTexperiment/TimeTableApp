import QtQuick 2.0
import QtQuick.Dialogs 1.3

MessageDialog {
    id: messageDialog
    title: "enter the test"
    text: "do you want to enter?"
    visible: false
    signal closedbox()
    standardButtons: StandardButton.Yes | StandardButton.No
       onYes:
       {
           console.log("MessageDialogueBox : pressed yes")
       }
       onNo:{
           console.log("MessageDialogueBox : pressed no")
       }

       onVisibleChanged: {
           if(visible == false)
               messageDialog.closedbox()
       }
}
