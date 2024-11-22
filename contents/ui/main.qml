/*
 * SPDX-FileCopyrightText: 2013 Heena Mahour <heena393@gmail.com>
 * SPDX-FileCopyrightText: 2013 Sebastian Kügler <sebas@kde.org>
 * SPDX-FileCopyrightText: 2014 Kai Uwe Broulik <kde@privat.broulik.de>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */
import QtQml
import QtQuick 2.0
import QtQuick.Layouts 1.1

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.plasma5support 2.0 as P5Support
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.workspace.calendar 2.0 as PlasmaCalendar

PlasmoidItem {
    id: root

    width: Kirigami.Units.gridUnit * 10
    height: Kirigami.Units.gridUnit * 4

    preferredRepresentation: compactRepresentation

    function getBeatsTime(): string {
        const now = dataSource.data["Local"]["DateTime"];

        // Add an hour to go from UTC to "BMT"
        const msBMT = now.getTime() + (60 * 60000);
        
        const secondsBMT = msBMT / 1000;
        const beats = secondsBMT % 86400 / 86400 * 1000;

        return "@" + beats.toFixed(2);
    }

    toolTipMainText: getBeatsTime()
    toolTipSubText: ""

    Plasmoid.backgroundHints: PlasmaCore.Types.ShadowBackground | PlasmaCore.Types.ConfigurableBackground

    P5Support.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: root.compactRepresentationItem.mouseArea.containsMouse ? 864 : 86400
        intervalAlignment: root.compactRepresentationItem.mouseArea.containsMouse ? P5Support.Types.NoAlignment : P5Support.Types.AlignToMinute
    }

    compactRepresentation: BeatsClock {
    }

    fullRepresentation: BeatsClock { 
        showCentibeats: true
    }
}
