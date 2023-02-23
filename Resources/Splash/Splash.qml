/*
    SPDX-FileCopyrightText:
    2023 Cequal-Catppuccin <core@Catppuccin.com>
    Based on
    2014 Marco Martin <mart@kde.org>

    SPDX-License-Identifier: MIT
*/

import QtGraphicalEffects 1.15
import QtQuick 2.5
import QtQuick.Window 2.2
import org.kde.plasma.core 2.0 as PlasmaCore

Rectangle {
    id: root
    color: "$mantle"

    property int stage

    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        DropShadow {
            anchors.fill: logo
            horizontalOffset: 0
            verticalOffset: 30
            radius: 200.0
            samples: 17
            color: "#000000"
            source: logo
            opacity: 0.1
        }

        Image {
            id: logo
            //match SDDM/lockscreen avatar positioning
            property real size: PlasmaCore.Units.gridUnit * 8

            anchors.centerIn: parent
            source: "images/Logo.png"

            sourceSize.width: size
            sourceSize.height: size
            smooth: true
            visible: true
        }

        Image {
            id: busyIndicator
            //in the middle of the remaining space
            y: parent.height - (parent.height - logo.y) / 2 - height/2
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/busywidget.svg"
            sourceSize.height: PlasmaCore.Units.gridUnit * 3.5
            sourceSize.width: PlasmaCore.Units.gridUnit * 3.5
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 2000
                loops: Animation.Infinite
                running: PlasmaCore.Units.longDuration > 1
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: PlasmaCore.Units.veryLongDuration * 2
        easing.type: Easing.InOutQuad
    }
}
