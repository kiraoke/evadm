import QtGraphicalEffects 1.12
import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: usernameField

    height: 15
    width: inputWidth
    selectByMouse: true

    font {
        family: config.FontFamily
        pointSize: 10
        bold: true
    }

    text: userModel.lastUser
    placeholderText: config.UserPlaceholderText
    horizontalAlignment: Text.AlignHCenter

    color: Qt.rgba(242, 243, 244, 0.75)
    selectionColor: config.InputTextColor
    renderType: Text.NativeRendering

    background: Rectangle {
        id: userFieldBackground

        color: Qt.rgba(0, 0, 0, 0)
        border.width: 0
        radius: config.Radius
    }

    transitions: Transition {
        PropertyAnimation {
            properties: "color, border.width"
            duration: 150
        }
    }
}
