import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import QtGraphicalEffects 1.0
import "../Components"
import "../Constants"

Item {
    id: root
    function disconnect() {
        API.get().disconnect()
        onDisconnect()
    }

    function reset() {

    }

    function onOpened() {
        if(mm2_version === '') mm2_version = API.get().get_mm2_version()
    }

    property string mm2_version: ''
    property var fiats: API.get().get_available_fiats()
    property string api_fiat: API.get().fiat

    InnerBackground {
        id: layout_background
        anchors.centerIn: parent
        Layout.alignment: Qt.AlignHCenter

        width: 400
        height: 750

        content: ColumnLayout {
            width: layout_background.width - 60
            height: layout_background.height

            ComboBoxWithTitle {
                id: combo_fiat
                title: API.get().empty_string + (qsTr("Fiat"))
                Layout.fillWidth: true

                field.model: fiats

                property bool initialized: false
                field.onCurrentIndexChanged: {
                    if(initialized) API.get().fiat = fiats[field.currentIndex]
                }
                Component.onCompleted: {
                    field.currentIndex = fiats.indexOf(API.get().fiat)
                    initialized = true
                }

                Connections {
                    target: root

                    function onApi_fiatChanged() {
                        const target_index = fiats.indexOf(api_fiat)
                        if(combo_fiat.field.currentIndex !== target_index)
                            combo_fiat.field.currentIndex = target_index
                    }
                }
            }

            Languages {
                Layout.alignment: Qt.AlignHCenter
            }

            HorizontalLine {
                Layout.fillWidth: true
                Layout.topMargin: 10
            }

            DefaultButton {
                Layout.fillWidth: true
                text: API.get().empty_string + (qsTr("Open Logs Folder"))
                onClicked: {
                    API.get().export_swaps_json()
                    const prefix = Qt.platform.os == "windows" ? "file:///" : "file://"
                    Qt.openUrlExternally(prefix + API.get().get_log_folder())
                }
            }

            DefaultButton {
                Layout.fillWidth: true
                text: API.get().empty_string + (qsTr("View Seed"))
                onClicked: recover_seed_modal.open()
            }

            RecoverSeedModal {
                id: recover_seed_modal
            }

            HorizontalLine {
                Layout.fillWidth: true
            }

            DefaultButton {
                Layout.fillWidth: true
                text: API.get().empty_string + (qsTr("Disclaimer and ToS"))
                onClicked: eula.open()
            }

            EulaModal {
                id: eula
                close_only: true
            }

            HorizontalLine {
                Layout.fillWidth: true
            }

            DangerButton {
                text: API.get().empty_string + (qsTr("Delete Wallet"))
                Layout.fillWidth: true
                onClicked: delete_wallet_modal.open()
            }

            DeleteWalletModal {
                id: delete_wallet_modal
            }

            DefaultButton {
                Layout.fillWidth: true
                text: API.get().empty_string + (qsTr("Log out"))
                onClicked: disconnect()
            }
        }
    }

    DefaultText {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.rightMargin: anchors.bottomMargin
        text_value: API.get().empty_string + (qsTr("mm2 version") + ":    " + mm2_version)
        font.pixelSize: Style.textSizeSmall
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
