From: Frans Pop <elendil@planet.nl>
Subject: [PATCH 3/6] acpi: thermal: display forced passive trip points in proc
Date: Wed, 26 Aug 2009 18:17:22 +0200
Message-ID: <1251303445-25317-4-git-send-email-elendil@planet.nl>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Cpsmtpm-eml109.kpnxchange.com ([195.121.3.13]:60672 "EHLO
	CPSMTPM-EML109.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751420AbZHZQRY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Aug 2009 12:17:24 -0400
In-Reply-To: <1251303445-25317-1-git-send-email-elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frans Pop <elendil@planet.nl>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>

Users can force passive cooling for a thermal zone that does not
have _PSV defined in ACPI by setting the passive attribute in sysfs.
It's useful to display such trip points in /proc/acpi/thermal_zone.

.../TZ1/cooling_mode:<setting not supported>
.../TZ1/polling_frequency:polling frequency:       10 seconds
.../TZ1/state:state:                   ok
.../TZ1/temperature:temperature:             53 C
.../TZ1/trip_points:critical (S5):           110 C
.../TZ1/trip_points:passive (forced):        95 C

And if not set (passive is 0):
.../TZ1/trip_points:passive (forced):<not set>

Signed-off-by: Frans Pop <elendil@planet.nl>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 564ea14..a4e507b 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1050,6 +1050,13 @@ static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
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
