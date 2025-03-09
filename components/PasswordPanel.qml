import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: passwordField

    focus: true
    selectByMouse: true
    echoMode: config.HidePassword === "true" ? TextInput.Password : TextInput.Normal
    passwordCharacter: "•"
    padding: -15
    cursorVisible: false
    onActiveFocusChanged: {
      cursorVisible = false
    }
    
    font {
        family: "Inter"
        pointSize: 28
        bold: true
    }

    placeholderText: config.PassPlaceholderText
    horizontalAlignment: TextInput.AlignHCenter

    color: "white"
    selectionColor: config.InputTextColor
    renderType: Text.NativeRendering

    background: Rectangle {
        id: passFieldBg
        color: Qt.rgba(0, 0, 0, 0)
        radius: config.Radius
    }
}
