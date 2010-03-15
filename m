From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/34] ACPI thermal: Don't invalidate thermal zone if critical
 trip point is bad
Date: Sun, 14 Mar 2010 21:40:52 -0400
Message-ID: <fa80945269f312bc609e8384302f58b03c916e12.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:15754 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756464Ab0COByd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:54:33 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA006Q7W1VW311@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:56:20 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

V2: Corrected integer/long conversion.

Some BIOSes return a negative value for the critical trip point.
Especially since Windows 2006...
We currently invalidate the whole thermal zone in this case.
But it may still be needed for cooling, also without critical
trip point.

This patch invalidates the critical trip point if no _CRT
function is found or if it returns negative values, but does
not invalidate the whole thermal zone in this case.

Reference: http://bugzilla.novell.com/show_bug.cgi?id=531547

Signed-off-by: Thomas Renninger <trenn@suse.de>
Tested-by: clarkt@cnsp.com
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 9073ada..77b8e1e 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -368,7 +368,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	int valid = 0;
 	int i;
 
-	/* Critical Shutdown (required) */
+	/* Critical Shutdown */
 	if (flag & ACPI_TRIPS_CRITICAL) {
 		status = acpi_evaluate_integer(tz->device->handle,
 				"_CRT", NULL, &tmp);
@@ -379,17 +379,19 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		 * Below zero (Celsius) values clearly aren't right for sure..
 		 * ... so lets discard those as invalid.
 		 */
-		if (ACPI_FAILURE(status) ||
-				tz->trips.critical.temperature <= 2732) {
+		if (ACPI_FAILURE(status)) {
+			tz->trips.critical.flags.valid = 0;
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+					  "No critical threshold\n"));
+		} else if (tmp <= 2732) {
+			printk(KERN_WARNING FW_BUG "Invalid critical threshold "
+			       "(%llu)\n", tmp);
 			tz->trips.critical.flags.valid = 0;
-			ACPI_EXCEPTION((AE_INFO, status,
-					"No or invalid critical threshold"));
-			return -ENODEV;
 		} else {
 			tz->trips.critical.flags.valid = 1;
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					"Found critical threshold [%lu]\n",
-					tz->trips.critical.temperature));
+					  "Found critical threshold [%lu]\n",
+					  tz->trips.critical.temperature));
 		}
 		if (tz->trips.critical.flags.valid == 1) {
 			if (crt == -1) {
-- 
1.7.0.2.201.g80978

