/*
 * SPDX-FileCopyrightText: 2013 Heena Mahour <heena393@gmail.com>
 * SPDX-FileCopyrightText: 2013 Sebastian Kügler <sebas@kde.org>
 * SPDX-FileCopyrightText: 2013 Martin Klapetek <mklapetek@kde.org>
 * SPDX-FileCopyrightText: 2014 David Edmundson <davidedmundson@kde.org>
 * SPDX-FileCopyrightText: 2014 Kai Uwe Broulik <kde@privat.broulik.de>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick 2.15
import QtQuick.Layouts 1.1

import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.plasmoid 2.0

Item {
    id: main

    Layout.minimumWidth: vertical ? 0 : sizehelper.paintedWidth + (Kirigami.Units.smallSpacing * 2)
    Layout.maximumWidth: vertical ? Infinity : Layout.minimumWidth
    Layout.preferredWidth: vertical ? undefined : Layout.minimumWidth

    Layout.minimumHeight: vertical ? sizehelper.paintedHeight + (Kirigami.Units.smallSpacing * 2) : 0
    Layout.maximumHeight: vertical ? Layout.minimumHeight : Infinity
    Layout.preferredHeight: vertical ? Layout.minimumHeight : Kirigami.Units.iconSizes.sizeForLabels * 2

    readonly property bool vertical: plasmoid.formFactor == PlasmaCore.Types.Vertical


    function getBeatsTime(): string {
        const now = dataSource.data["Local"]["DateTime"];

        // Add an hour to go from UTC to "BMT"
        const msBMT = now.getTime() + (60 * 60000);
        
        const secondsBMT = msBMT / 1000;
        const beats = secondsBMT % 86400 / 86400 * 1000;

        if(showCentibeats)
        {
            return "@" + beats.toFixed(2);
        }
        else
        {
            return "@" + Math.floor(beats);
        }
    }

    activeFocusOnTab: true

    Accessible.name: Plasmoid.title
    Accessible.description: timeLabel.text
    Accessible.role: Accessible.Button

    PlasmaComponents3.Label  {
        id: timeLabel
        font {
            weight: Font.Normal
            italic: false
            pixelSize: 1024
            pointSize: 0 // we need to unset pointSize otherwise it breaks the Text.Fit size mode
        }
        minimumPixelSize: Kirigami.Units.iconSizes.sizeForLabels
        fontSizeMode: Text.Fit
        text: getBeatsTime()

        wrapMode: Text.NoWrap
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        height: 0
        width: 0
        anchors {
            fill: parent
            leftMargin: Kirigami.Units.smallSpacing
            rightMargin: Kirigami.Units.smallSpacing
        }
    }

    property bool wasExpanded: false

    readonly property alias mouseArea: mouseArea

    property bool showCentibeats: plasmoid.configuration.showCentibeats ? true : false;

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        // onPressed: wasExpanded = root.expanded
        // onClicked: root.expanded = !wasExpanded
    }

    Text {
        id: sizehelper
        font.weight: timeLabel.font.weight
        font.italic: timeLabel.font.italic
        font.pixelSize: vertical ? Kirigami.Units.gridUnit * 2 : 1024 // random "big enough" size - this is used as a max pixelSize by the fontSizeMode
        minimumPixelSize: Math.round(Kirigami.Units.gridUnit / 2)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: timeLabel.text
        fontSizeMode: vertical ? Text.HorizontalFit : Text.VerticalFit

        wrapMode: Text.NoWrap
        visible: false
        anchors {
            fill: parent
            leftMargin: Kirigami.Units.smallSpacing
            rightMargin: Kirigami.Units.smallSpacing
        }
    }
}
