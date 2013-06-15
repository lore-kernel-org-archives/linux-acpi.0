From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / dock: Take ACPI scan lock in write_undock()
Date: Sun, 16 Jun 2013 00:16:31 +0200
Message-ID: <1886227.aipra45Zvt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Toshi Kani <toshi.kani@hp.com>, LKML <linux-kernel@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since commit 3757b94 (ACPI / hotplug: Fix concurrency issues and
memory leaks) acpi_bus_scan() and acpi_bus_trim() must always be
called under acpi_scan_lock, but currently the following scenario
violating that requirement is possible:

 write_undock()
  handle_eject_request()
   hotplug_dock_devices()
    dock_remove_acpi_device()
     acpi_bus_trim()

Fix that by making write_undock() acquire acpi_scan_lock before
calling handle_eject_request() as appropriate (begin_undock() is
under the lock too in analogy with acpi_dock_deferred_cb()).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 3.9+ <stable@vger.kernel.org>
---
 drivers/acpi/dock.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-pm/drivers/acpi/dock.c
===================================================================
--- linux-pm.orig/drivers/acpi/dock.c
+++ linux-pm/drivers/acpi/dock.c
@@ -868,8 +868,10 @@ static ssize_t write_undock(struct devic
 	if (!count)
 		return -EINVAL;
 
+	acpi_scan_lock_acquire();
 	begin_undock(dock_station);
 	ret = handle_eject_request(dock_station, ACPI_NOTIFY_EJECT_REQUEST);
+	acpi_scan_lock_release();
 	return ret ? ret: count;
 }
 static DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
