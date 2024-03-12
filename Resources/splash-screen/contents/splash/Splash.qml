/*
    SPDX-FileCopyrightText:
    2023 Cequal-Catppuccin <core@Catppuccin.com>
    Based on
    2014 Marco Martin <mart@kde.org>

    SPDX-License-Identifier: MIT
*/

import QtQuick
import org.kde.kirigami 2 as Kirigami

Rectangle {
    id: root
    color: "REPLACE--MANTLE"

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
        //TODO: Figure out how to port DropShadow to KDE6, erase comment when ported.
/*
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
*/
        Image {
            id: logo
            //match SDDM/lockscreen avatar positioning
            readonly property real size: Kirigami.Units.gridUnit * 8

            anchors.centerIn: parent
            source: "images/Logo.png"

            sourceSize.width: size
            sourceSize.height: sizes
            smooth: true
            visible: true
        }

        Image {
            id: busyIndicator
            //in the middle of the remaining space
            y: parent.height - (parent.height - logo.y) / 2 - height/2
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/busywidget.svg"
            sourceSize.height: Kirigami.Units.gridUnit * 3.5
            sourceSize.width: Kirigami.Units.gridUnit * 3.5
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 2000
                loops: Animation.Infinite
                running: Kirigami.Units.longDuration > 1
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: Kirigami.Units.veryLongDuration * 2
        easing.type: Easing.InOutQuad
    }
}
