From: Frans Pop <elendil@planet.nl>
Subject: [PATCH] acpi: thermal: display forced passive trip points in proc
Date: Fri, 21 Aug 2009 16:17:02 +0200
Message-ID: <200908211617.03574.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755619AbZHUORF@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Users can force a passive trip point for a thermal zone that does not
have _PSV defined in ACPI by setting the passive attribute in sysfs.
It's useful to display such trip points in /proc/acpi/thermal_zone.

.../TZ1/cooling_mode:<setting not supported>
.../TZ1/polling_frequency:polling frequency:       10 seconds
.../TZ1/state:state:                   ok
.../TZ1/temperature:temperature:             56 C
.../TZ1/trip_points:critical (S5):           110 C
.../TZ1/trip_points:passive:                 95 C: forced

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Zhang Rui <rui.zhang@intel.com>
---

Now that I've got this set on my notebook, I also want to see that
it's set :-)

Cheers,
FJP

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 564ea14..c64cfa9 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1050,6 +1050,10 @@ static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
 				   acpi_device_bid(device));
 		}
 		seq_puts(seq, "\n");
+	} else if (tz->thermal_zone->forced_passive) {
+		seq_printf(seq,
+			   "passive:                 %i C: forced",
+			   tz->thermal_zone->forced_passive / 1000);
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
