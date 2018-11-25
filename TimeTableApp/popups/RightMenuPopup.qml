import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.2
import "../popups"
import "../headers"
import "../pages"
import "../toolcomps"

Menu {
    id: menuBar
    x: parent.x+parent.width-width
    y: parent.y
    property var settingsrightmenu: null
    property var  sharetext: null
    property var aboutpopup: null
    property var msgdbbox: null
    property var showtime: null

    MenuItem {
        id:rightmenusettings
        text:qsTr("Settings")
       icon.source:"qrc:/images/settings.png"

      onTriggered: {
          if(settingsrightmenu == null)
          {
              settingsrightmenu = Qt.createQmlObject("SettingPopup{ }",homepage);
              settingsrightmenu.onClosed.connect(deleteobj)
              settingsrightmenu.open()
          }

          function deleteobj()
          {
              if(settingsrightmenu != null)
                  settingsrightmenu.destroy()
          }
      }
    }

    MenuItem {
        id:rightmenushare
        text:qsTr("Share")
        icon.source:"qrc:/images/share.png"
        property string textmessage: "app 1.0 please download from the link"
        property url applink: "google.in"

        onTriggered:
        {
            if(sharetext === null)
            {
                sharetext = Qt.createQmlObject("import QtShareButton 1.0;ShareUtils{} ",homepage);
                sharetext.share(textmessage,applink);
                sharetext.destroy();
            }
            else
            {
                console.log("share txt alraedy exists")
               sharetext.share(textmessage,applink);
            }
        }
    }

    MenuItem {
        id:currentTimeDate
         text:qsTr("Time")
         icon.source: "qrc:/images/currentTime.png"
         onTriggered: {
             if(showtime === null)
             {
                 //Qt.createQmlObject("EditActivityPopup{}",itemdelg);
                 showtime = Qt.createQmlObject("PopupTimeDate{ }",homepage);
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

    MenuItem {
        id:rightmenuexit
         text:qsTr("Exit")
         icon.source: "qrc:/images/exit.png"
         onTriggered: {
             if(msgdbbox === null)
             {
                 msgdbbox = Qt.createQmlObject("MessageDialogueBox{ }",homepage);
                 msgdbbox.title= "Exit "
                 msgdbbox.text= "exit the App?"
                 msgdbbox.yes.connect(exitapp)
                 msgdbbox.no.connect(nopressed)
                 msgdbbox.closedbox.connect(deleteobj)
                 //msgdbbox.visible =true
                 msgdbbox.open()

             }
             else
             {
                 console.log("msgdbbox alraedy exists")
                 msgdbbox.open()
             }

             function deleteobj()
             {
                 if(msgdbbox != null)
                     msgdbbox.destroy()
             }
         }
    }


    function exitapp()
    {
        if(msgdbbox != null)
            msgdbbox.destroy()

        Qt.quit()
        console.log("exitapp : quit pressed !! qutting application !!")
    }
    function nopressed()
    {
        console.log("nopressed : not qutting app")
        if(msgdbbox != null)
            msgdbbox.destroy()

    }
}
