From: Len Brown <len.brown@intel.com>
Subject: [PATCH 1/3] ACPI: gracefully print null trip-point device
Date: Sat, 23 Jun 2007 11:04:46 -0400
Message-ID: <11826110891391-git-send-email-len.brown@intel.com>
References: <1182611088203-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19465 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758003AbXFWPE5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 Jun 2007 11:04:57 -0400
In-Reply-To: <1182611088203-git-send-email-len.brown@intel.com>
Message-Id: <e7c746ef098770f863ba294adac5b30d124ba469.1182611002.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

if acpi_bus_get_device() returns NULL, print nothing
instead of "<NUL" in /proc/acpi/thermal_zone/*/trip_points

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 194ecfe..88a6fc7 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -828,6 +828,8 @@ static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_thermal *tz = seq->private;
 	struct acpi_device *device;
+	acpi_status status;
+
 	int i = 0;
 	int j = 0;
 
@@ -850,8 +852,10 @@ static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
 			   tz->trips.passive.tc1, tz->trips.passive.tc2,
 			   tz->trips.passive.tsp);
 		for (j = 0; j < tz->trips.passive.devices.count; j++) {
-			acpi_bus_get_device(tz->trips.passive.devices.handles[j], &device);
-			seq_printf(seq, "%4.4s ", acpi_device_bid(device));
+			status = acpi_bus_get_device(tz->trips.passive.devices.
+						     handles[j], &device);
+			seq_printf(seq, "%4.4s ", status ? "" :
+				   acpi_device_bid(device));
 		}
 		seq_puts(seq, "\n");
 	}
@@ -863,8 +867,11 @@ static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
 			   i,
 			   KELVIN_TO_CELSIUS(tz->trips.active[i].temperature));
 		for (j = 0; j < tz->trips.active[i].devices.count; j++){
-			acpi_bus_get_device(tz->trips.active[i].devices.handles[j], &device);
-			seq_printf(seq, "%4.4s ", acpi_device_bid(device));
+			status = acpi_bus_get_device(tz->trips.active[i].
+						     devices.handles[j],
+						     &device);
+			seq_printf(seq, "%4.4s ", status ? "" :
+				   acpi_device_bid(device));
 		}
 		seq_puts(seq, "\n");
 	}
-- 
1.5.2.1.255.gca6c0
