import QtQuick 2.0
import "../toolcomps"
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3

Popup{
    focus: true
    modal: true
    dim: true
    x: parent.width/2-width/2
    y:parent.height/2-height/2
    Material.elevation: 8
    width :Math.min(parent.width / 1.25 , 250)
    height: Math.min(parent.height / 2 , 250)

    background: Rectangle{
        color: Material.color(Material.Orange)
        radius: width/2
    }
    contentItem:CurrentTime{}

    Component.onCompleted: {
        console.log("timedate popup created")
    }
    Component.onDestruction: {
         console.log("timedate popup destroyed")
    }
}
