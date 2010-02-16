From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] ACPI thermal: Check for thermal zone requirement
Date: Tue, 16 Feb 2010 22:55:51 +0100
Message-ID: <1266357351-20224-2-git-send-email-trenn@suse.de>
References: <1266357351-20224-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:36714 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933264Ab0BPV41 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Feb 2010 16:56:27 -0500
In-Reply-To: <1266357351-20224-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>

ACPI spec says (11.5 Thermal Zone Interface Requirements):
   A thermal zone must contain at least one trip point
   (critical, near critical, active, or passive)

Check this once at init time.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Tested-by: clarkt@cnsp.com
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
---
 drivers/acpi/thermal.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 8fa71b8..09b757a 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -577,7 +577,23 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 
 static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 {
-	return acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
+	int i, valid, ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
+
+	if (ret)
+		return ret;
+
+	valid = tz->trips.critical.flags.valid |
+		tz->trips.hot.flags.valid |
+		tz->trips.passive.flags.valid;
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
+		valid |= tz->trips.active[i].flags.valid;
+
+	if (!valid) {
+		printk(KERN_WARNING FW_BUG "No valid trip found\n");
+		return -ENODEV;
+	}
+	return 0;
 }
 
 static void acpi_thermal_check(void *data)
-- 
1.6.3

