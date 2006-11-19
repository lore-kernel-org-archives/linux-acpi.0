From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Show devices for active/passive cooling in thermal
	trip_points file
Date: Sun, 19 Nov 2006 23:01:40 +0100
Message-ID: <1163973700.3562.13.camel@sublime.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:28846 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933430AbWKSWEx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Nov 2006 17:04:53 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, fseidel@suse.de, Arjan van de Ven <arjan@linux.intel.com>

Len, can you queue this one for after 2.6.19 inclusion, please.
With this and a firmwarekit test it should be possible to identify
not working fans as it happened on some HPs in 2.6.16 and later
automatically.

Thanks,

   Thomas

Show devices for active/passive cooling in thermal trip_points file

Currently the internal pointer to a ACPI handle of a device
which is used for active/passive cooling at a certain temperature
is exported to userspace. This pointer isn't of any use for userspace.

Instead, export the device name, so
that automated tests (e.g. linuxfirmwarekit) can check whether the
device (at least fans for active cooling trip points) really get activated
on the right temperature.

Signed-off-by: Thomas Renninger <trenn@suse.de>

 drivers/acpi/thermal.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

Index: linux-2.6.19-rc6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/acpi/thermal.c
+++ linux-2.6.19-rc6/drivers/acpi/thermal.c
@@ -838,6 +838,7 @@ static int acpi_thermal_temp_open_fs(str
 static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_thermal *tz = (struct acpi_thermal *)seq->private;
+	struct acpi_device *device;
 	int i = 0;
 	int j = 0;
 
@@ -860,9 +861,8 @@ static int acpi_thermal_trip_seq_show(st
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
@@ -873,9 +873,10 @@ static int acpi_thermal_trip_seq_show(st
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
 



