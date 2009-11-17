From: akpm@linux-foundation.org
Subject: [patch 07/12] acpi: thermal: display forced passive trip points in proc
Date: Tue, 17 Nov 2009 14:27:33 -0800
Message-ID: <200911172227.nAHMRX7i023346@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60487 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756354AbZKQW2p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 17:28:45 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, elendil@planet.nl, mjg59@srcf.ucam.org, rui.zhang@intel.com

From: Frans Pop <elendil@planet.nl>

Users can force a passive trip point for a thermal zone that does not have
_PSV defined in ACPI by setting the passive attribute in sysfs.  It's
useful to display such trip points in /proc/acpi/thermal_zone.

.../TZ1/cooling_mode:<setting not supported>
.../TZ1/polling_frequency:polling frequency:       10 seconds
.../TZ1/state:state:                   ok
.../TZ1/temperature:temperature:             53 C
.../TZ1/trip_points:critical (S5):           110 C
.../TZ1/trip_points:passive (forced):        95 C

And if not set (passive is 0):
.../TZ1/trip_points:passive (forced):<not set>

Signed-off-by: Frans Pop <elendil@planet.nl>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/thermal.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff -puN drivers/acpi/thermal.c~acpi-thermal-display-forced-passive-trip-points-in-proc drivers/acpi/thermal.c
--- a/drivers/acpi/thermal.c~acpi-thermal-display-forced-passive-trip-points-in-proc
+++ a/drivers/acpi/thermal.c
@@ -1052,6 +1052,13 @@ static int acpi_thermal_trip_seq_show(st
 				   acpi_device_bid(device));
 		}
 		seq_puts(seq, "\n");
+	} else {
+		seq_printf(seq, "passive (forced):");
+		if (tz->thermal_zone->forced_passive)
+			seq_printf(seq, "        %i C\n",
+				   tz->thermal_zone->forced_passive / 1000);
+		else
+			seq_printf(seq, "<not set>\n");
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
_
