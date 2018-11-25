import QtQuick 2.2
import QtCharts 2.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import TimeTableModel.custom 1.0
import "../headers"
import "../toolcomps"


Page {
    id:timetablepage
    header: TimeTableHeader {
        id:hdr
    }

    SwipeView{
        id:swpview
        //anchors.fill: parent
        anchors.top:parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
      //  currentIndex: tbbar.currentIndex
        currentIndex: hdr.dayTabCurrentindex

        property var tabbarmodel: [{name:"MON"},{name:"TUE"},{name:"WED"},{name:"THU"},
                                  {name:"FRI"},{name:"SAT"},{name:"SUN"}]
        Repeater{
            id:rptr
            model: swpview.tabbarmodel
            anchors.fill: parent
           delegate:  ListView {
                id: homeTab
           // anchors.fill: parent

                spacing: 5
                property string tableName: modelData.name
                model:timeTableModel/*QLSqlTimeTableModel{
                    id:lll
                    dayTableName_m:homeTab.tableName

                    Component.onCompleted: {
                        lll.setsqlquery(dayTableName_m)
                    }

                    }*/
               // flickableDirection: Flickable.AutoFlickIfNeeded
                snapMode:ListView.SnapToItem

                //orientation :Qt.Horizontal
                displaced: Transition {
                      NumberAnimation { properties: "x,y"; duration: 500 }
                }
                moveDisplaced :Transition {
                    NumberAnimation { properties: "x,y"; duration: 1000 }
                }
                move:Transition {
                    NumberAnimation { properties: "x,y"; duration: 1000 }
                }
                add:Transition {
                    PropertyAnimation { properties: "opacity";from: 0;to:1; duration: 1000 }
                }
                remove: Transition {
                    PropertyAnimation { properties: "opacity"; duration: 1000; from: 1;to:0;}
                }
     //timeTableModel  //timetablemodel
                delegate: TimeTableDelegate{
                   opacity: 1
                  implicitWidth: timetablepage.width
                  implicitHeight: 120
                }

                FloatingButton {
                    id:plusfloatbutton
                    buttonheight:50
                    buttonwidth: 50
                    backgroundColor:Material.color(Material.Green)
                    shadowcolor:"black"
                    showShadow:true
                    imageSource: Qt.resolvedUrl("qrc:/images/add.png")
                    z: 1
                    anchors.margins: 20
                   // anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    scale: 1
                    ToolTip.text: "add activity"
                    ToolTip.visible: pressed
                    ToolTip.delay:500
                    ToolTip.timeout: 1000
                    onClicked: {
                        //for relational table model
                        //model.append(homeTab.tableName)
                        //model.setsqlquery(homeTab.tableName)

                       model.sourceModel_m.append(homeTab.tableName);

                    }
                }
            }
        }
    }


}
