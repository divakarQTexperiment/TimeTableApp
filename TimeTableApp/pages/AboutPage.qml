import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import "../headers"



Page {
    id:aboutpage
    header: HeaderCommon {
        id:header
        toolbarcolor: Material.color(Material.Teal)
        labeltext:qsTr("ABOUT")
    }

   /* background:*/ Rectangle{
        anchors.fill: parent
        anchors.margins: 5
     color: Material.color(Material.Shade500)
     border.width: 5
     radius: 25
     border.color: Material.color(Material.Grey)
    //}

      Text {
          id: aboutText
          height: parent.height
          width: parent.width
          font.pointSize: 15
          topPadding: 25
          leftPadding: 20
          rightPadding: 20
          bottomPadding: 25
          renderType:Text.NativeRendering
          font.capitalization: Font.AllUppercase
          //font.bold: true
          color:  "#FFFFFF"
          wrapMode: Text.WordWrap
          text:qsTr("APP 1.O developed by companyX.only for educational purpose.for more INFO contact info@companyX.com");
      }
    }

}
