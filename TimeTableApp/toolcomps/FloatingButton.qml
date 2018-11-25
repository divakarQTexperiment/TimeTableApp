import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

Button {
    id: button
    property alias imageSource: contentImage.source
    property alias backgroundColor: buttonBackground.color
    property color shadowcolor: "grey"
    //property alias primaryColor: buttonBackground.color
    property bool showShadow: false
    property alias buttonheight: buttonBackground.implicitHeight
    property alias buttonwidth: buttonBackground.implicitWidth
    property alias iconheight: icon.implicitHeight
    property alias iconwidth: icon.implicitWidth

    focusPolicy: Qt.NoFocus
    contentItem:
        Item {
        id:icon
        implicitHeight: 24
        implicitWidth: 24
        Image {
            id: contentImage
            anchors.centerIn: parent
        }
    }
    background:
        Rectangle {
        id: buttonBackground
        implicitWidth: 56
        implicitHeight: 56
        radius: width / 2
        opacity: button.pressed ? 0.75 : 1.0
        layer.enabled: button.showShadow
        layer.effect: DropShadow {
            id:shadow
            verticalOffset: 3
            horizontalOffset: 1
             color:shadowcolor
            samples: button.pressed ? 20 : 10
            spread: 0.5
        }
    }
}
