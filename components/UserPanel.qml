import QtGraphicalEffects 1.12
import QtQml.Models 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15

Column {
  property var username: usernameField.text

  spacing: 10

  Component.onCompleted: {
    if (userPicture.enabled) {
      userPicture.source = userWrapper.items.get(userList.currentIndex).model.icon;
    }
  }

  DelegateModel {
    id: userWrapper

    model: userModel

    delegate: ItemDelegate {
      id: userEntry

      enabled: config.UserPictureEnabled === "true"
      visible: config.UserPictureEnabled === "true"

      height: inputHeight
      width: parent.width
      highlighted: userList.currentIndex === index

      contentItem: Text {
        font {
          family: config.FontFamily
          pointSize: config.FontSize
          bold: true
        }

        text: name
        renderType: Text.NativeRendering
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: highlighted ? config.PopupActiveTextColor : config.PopupActiveColor
      }

      background: Rectangle {
        id: userEntryBg

        color: highlighted ? config.PopupActiveColor : config.PopupColor
        radius: config.Radius
      }

      transitions: Transition {
        PropertyAnimation {
          property: "color"
          duration: 150
        }
      }
    }
  }

  Popup {
    id: userPopup

    enabled: config.UserPictureEnabled === "true"

    width: inputWidth
    padding: 15

    background: Rectangle {
      radius: config.Radius * 1.8
      color: config.PopupColor
    }

    contentItem: ListView {
      id: userList

      implicitHeight: contentHeight
      spacing: 8
      model: userWrapper
      currentIndex: userModel.lastIndex
      clip: true
    }

    enter: Transition {
      ParallelAnimation {
        NumberAnimation {
          property: "opacity"
          from: 0
          to: 1
          duration: 400
          easing.type: Easing.OutExpo
        }

        NumberAnimation {
          property: "y"
          from: (inputWidth / 3) - userPopup.padding - (inputHeight * userList.count * 0.5) - (userList.spacing * (userList.count - 1) * 0.5) + (inputWidth * 0.1)
          to: (inputWidth / 3) - userPopup.padding - (inputHeight * userList.count * 0.5) - (userList.spacing * (userList.count - 1) * 0.5)
          duration: 500
          easing.type: Easing.OutExpo
        }
      }
    }

    exit: Transition {
      NumberAnimation {
        property: "opacity"
        from: 1
        to: 0
        duration: 300
        easing.type: Easing.OutExpo
      }
    }
  }

  Item {
    width: inputWidth
    implicitHeight: pictureBorder.height

    Popup {
      id: incorrectPopup

      height: incorrectText.paintedHeight * 2
      width: inputWidth
      y: (pictureBorder.height - height) / 2
      onOpened: incorrectTimer.start()

      Timer {
        id: incorrectTimer

        interval: 3000
        onTriggered: incorrectPopup.close()
      }

      contentItem: Text {
        id: incorrectText

        font {
          family: config.FontFamily
          pointSize: config.FontSize
          bold: true
        }

        renderType: Text.NativeRendering
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: config.PopupActiveColor
        text: "Incorrect username\nor password!"
      }

      enter: Transition {
        ParallelAnimation {
          NumberAnimation {
            property: "opacity"
            from: 0
            to: 1
            duration: 400
            easing.type: Easing.OutExpo
          }

          NumberAnimation {
            property: "x"
            from: incorrectPopup.x - (inputWidth * 0.1)
            to: incorrectPopup.x
            duration: 500
            easing.type: Easing.OutElastic
          }
        }
      }

      exit: Transition {
        NumberAnimation {
          property: "opacity"
          from: 1
          to: 0
          duration: 300
          easing.type: Easing.OutExpo
        }
      }
    }
  }

  UserFieldPanel {
    id: usernameField

    height: inputHeight
    width: inputWidth
  }

  Connections {
    function onLoginSucceeded() {}

    function onLoginFailed() {
      incorrectPopup.open();
    }

    target: sddm
  }
}
