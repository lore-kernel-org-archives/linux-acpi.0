From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/23] ACPI: Reject below-freezing temperatures as invalid
 critical temperatures
Date: Wed, 11 Jun 2008 03:59:25 -0400
Message-ID: <3cd673ebf929f15e29ee7abd3f822382d64f68d0.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:43667 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbYFKH77 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:59 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2A008DCGVBAVP2@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:36 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Arjan van de Ven <arjan@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Arjan van de Ven <arjan@linux.intel.com>

My laptop thinks that it's a good idea to give -73C as the critical
CPU temperature.... which isn't the best thing since it causes a shutdown
right at bootup.

Temperatures below freezing are clearly invalid critical thresholds
so just reject these as such.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 504385b..84c795f 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -364,10 +364,17 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 	if (flag & ACPI_TRIPS_CRITICAL) {
 		status = acpi_evaluate_integer(tz->device->handle,
 				"_CRT", NULL, &tz->trips.critical.temperature);
-		if (ACPI_FAILURE(status)) {
+		/*
+		 * Treat freezing temperatures as invalid as well; some
+		 * BIOSes return really low values and cause reboots at startup.
+		 * Below zero (Celcius) values clearly aren't right for sure..
+		 * ... so lets discard those as invalid.
+		 */
+		if (ACPI_FAILURE(status) ||
+				tz->trips.critical.temperature <= 2732) {
 			tz->trips.critical.flags.valid = 0;
 			ACPI_EXCEPTION((AE_INFO, status,
-					"No critical threshold"));
+					"No or invalid critical threshold"));
 			return -ENODEV;
 		} else {
 			tz->trips.critical.flags.valid = 1;
-- 
1.5.6.rc2.23.gea81e

