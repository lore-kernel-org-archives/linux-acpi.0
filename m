From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] ACPI / dock: Cleanups and simplifications
Date: Fri, 28 Jun 2013 21:44:18 +0200
Message-ID: <1640211.P0jyS5muX2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

The following patches clean up and simplify dock.c slightly.

They conflict with the Gerry's changes currently, but I'll fix them up if
everyone is comfortable with the changes.

[1/4] Remove hp_lock from struct dock_station.
[2/4] Rework find_dock_devices() (so that it doesn't worry about parents).
[3/4] Walk the list of dependent devices in reverse order on removal.
[4/4] Simplify dock_init_hotplug() and dock_release_hotplug()

Patches [1-3/4] have been tested by Alexander Patrakov on his Sony Vaio with
a docking station and he haven't seen any problems related to them.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
