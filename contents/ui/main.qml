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

    // This could likely be abstracted so as to not be a repeat of the function in BeatsClock.qml
    function getBeatsTime(): string {
        const now = dataSource.data["Local"]["DateTime"];

        // Add an hour to go from UTC to "BMT"
        const msBMT = now.getTime() + (60 * 60000);
        
        const secondsBMT = msBMT / 1000;
        const beats = secondsBMT % 86400 / 86400 * 1000;

        return "@" + beats.toFixed(2);
    }

    // This seg faults eventually so I did the lazy route of just having the interval be 864 all the time.
    // Probably uses more resources.
    // function alignInterval(): int {
    //     // Interval is defined as distance between now and next full beat.

    //     const now = dataSource.data["Local"]["DateTime"];

    //     // Add an hour to go from UTC to "BMT"
    //     const msBMT = now.getTime() + (60 * 60000);
        
    //     const secondsBMT = msBMT / 1000;
    //     const beats = secondsBMT % 86400 / 86400 * 1000;

    //     const nextBeat = Math.ceil(beats);

    //     const calcDelay = Math.round(86400 * (nextBeat - beats));

    //     // This didn't work as a ternary. Don't know why.
    //     if(calcDelay <= 864)
    //     {
    //         return 86400;
    //     }
    //     else {
    //         return calcDelay;
    //     }
    // }

    toolTipMainText: getBeatsTime()
    toolTipSubText: ""

    Plasmoid.backgroundHints: PlasmaCore.Types.ShadowBackground | PlasmaCore.Types.ConfigurableBackground

    P5Support.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        // interval: root.compactRepresentationItem.mouseArea.containsMouse || plasmoid.configuration.showCentibeats ? 864 : alignInterval()
        interval: 864
        intervalAlignment: P5Support.Types.NoAlignment
    }

    compactRepresentation: BeatsClock {
    }

    fullRepresentation: BeatsClock { 
        showCentibeats: true
    }
}
