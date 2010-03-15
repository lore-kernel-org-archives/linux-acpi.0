From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/34] ACPI thermal: Check for thermal zone requirement
Date: Sun, 14 Mar 2010 21:40:51 -0400
Message-ID: <8b7ef6d8f16274da42344cd50746ddb1c93c25ea.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:41630 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756464Ab0COBxc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:53:32 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA005SZVX7IRG2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:53:32 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

ACPI spec says (11.5 Thermal Zone Interface Requirements):
   A thermal zone must contain at least one trip point
   (critical, near critical, active, or passive)

Check this once at init time.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Tested-by: clarkt@cnsp.com
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 9073ada..e9f28e0 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -575,7 +575,23 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 
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
1.7.0.2.201.g80978

