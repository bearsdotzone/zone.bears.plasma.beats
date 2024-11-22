/*
 * SPDX-FileCopyrightText: 2013 Bhushan Shah <bhush94@gmail.com>
 * SPDX-FileCopyrightText: 2013 Sebastian Kügler <sebas@kde.org>
 * SPDX-FileCopyrightText: 2014 Kai Uwe Broulik <kde@privat.broulik.de>
 *
 * SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
 */

import QtQuick 2.0
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Layouts 1.0
import org.kde.kirigami 2.5 as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    property alias cfg_showCentibeats: showCentibeats.checked

    Kirigami.FormLayout {
        QQC2.CheckBox {
            id: showCentibeats
            Kirigami.FormData.label: i18nc("@title:group", "Show centibeats")
            text: i18nc("@option:check", "Show centibeats")
        }
    }
}
