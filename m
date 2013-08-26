From: tianyu.lan@intel.com
Subject: [PATCH V2] ACPI/Thermal: Add check of "_TZD" availability and evaluating result
Date: Mon, 26 Aug 2013 10:14:30 +0800
Message-ID: <1377483270-16841-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53187 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755262Ab3HZCXe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Aug 2013 22:23:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org

From: Lan Tianyu <tianyu.lan@intel.com>

Some machines don't provide _TZD. So add check of "_TZD" availability
before doing futher operations. This patch also adds the check of
evaluating result.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 Change sicne v1:
	Arrange the whitespace, using "tz->devices = devices"
instead of memcpy() and sizeof(devices) instead of sizeof(struct ...)

 drivers/acpi/thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 09f9340..177ecca 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -492,14 +492,14 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			break;
 	}
 
-	if (flag & ACPI_TRIPS_DEVICES) {
-		memset(&devices, 0, sizeof(struct acpi_handle_list));
+	if ((flag & ACPI_TRIPS_DEVICES)
+	    && acpi_has_method(tz->device->handle, "_TZD")) {
+		memset(&devices, 0, sizeof(devices));
 		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
 						NULL, &devices);
-		if (memcmp(&tz->devices, &devices,
-				sizeof(struct acpi_handle_list))) {
-			memcpy(&tz->devices, &devices,
-				sizeof(struct acpi_handle_list));
+		if (ACPI_SUCCESS(status) && memcmp(&tz->devices, &devices,
+		    sizeof(devices))) {
+			tz->devices = devices;
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
 		}
 	}
-- 
1.8.4.rc0.1.g8f6a3e5.dirty

