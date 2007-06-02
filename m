From: Len Brown <len.brown@intel.com>
Subject: [PATCH 2/8] ACPI: thermal: Replace pointer with name in trip_points
Date: Sat,  2 Jun 2007 01:15:38 -0400
Message-ID: <11807613463371-git-send-email-len.brown@intel.com>
References: <1180761344795-git-send-email-len.brown@intel.com>
 <11807613453368-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48596 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460AbXFBFPq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Jun 2007 01:15:46 -0400
In-Reply-To: <11807613453368-git-send-email-len.brown@intel.com>
Message-Id: <68ccfaa8222f2a26f0689fad9e8c0c3f4c19f599.1180761191.git.len.brown@intel.com>
In-Reply-To: <0efabac9b7c8535eeb199d2f16d3eb44dc4761b2.1180761191.git.len.brown@intel.com>
References: <0efabac9b7c8535eeb199d2f16d3eb44dc4761b2.1180761191.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

For users with active thermal trip points, they need
the fan's name, rather than its address, to understand
where to look to observe and control fan state.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 1ada017..194ecfe 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -827,6 +827,7 @@ static int acpi_thermal_temp_open_fs(struct inode *inode, struct file *file)
 static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_thermal *tz = seq->private;
+	struct acpi_device *device;
 	int i = 0;
 	int j = 0;
 
@@ -849,9 +850,8 @@ static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
 			   tz->trips.passive.tc1, tz->trips.passive.tc2,
 			   tz->trips.passive.tsp);
 		for (j = 0; j < tz->trips.passive.devices.count; j++) {
-
-			seq_printf(seq, "0x%p ",
-				   tz->trips.passive.devices.handles[j]);
+			acpi_bus_get_device(tz->trips.passive.devices.handles[j], &device);
+			seq_printf(seq, "%4.4s ", acpi_device_bid(device));
 		}
 		seq_puts(seq, "\n");
 	}
@@ -862,9 +862,10 @@ static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
 		seq_printf(seq, "active[%d]:               %ld C: devices=",
 			   i,
 			   KELVIN_TO_CELSIUS(tz->trips.active[i].temperature));
-		for (j = 0; j < tz->trips.active[i].devices.count; j++)
-			seq_printf(seq, "0x%p ",
-				   tz->trips.active[i].devices.handles[j]);
+		for (j = 0; j < tz->trips.active[i].devices.count; j++){
+			acpi_bus_get_device(tz->trips.active[i].devices.handles[j], &device);
+			seq_printf(seq, "%4.4s ", acpi_device_bid(device));
+		}
 		seq_puts(seq, "\n");
 	}
 
-- 
1.5.2.146.gb75c6
