From: tianyu.lan@intel.com
Subject: [PATCH] ACPI/Thermal: Add check of "_TZD" availability and evaluating result
Date: Sat, 24 Aug 2013 17:01:28 +0800
Message-ID: <1377334888-6384-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:17663 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428Ab3HXJKm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Aug 2013 05:10:42 -0400
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
 drivers/acpi/thermal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 09f9340..6809fbd 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -492,11 +492,12 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			break;
 	}
 
-	if (flag & ACPI_TRIPS_DEVICES) {
+	if ((flag & ACPI_TRIPS_DEVICES)
+			&& acpi_has_method(tz->device->handle, "_TZD")) {
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
 						NULL, &devices);
-		if (memcmp(&tz->devices, &devices,
+		if (ACPI_SUCCESS(status) && memcmp(&tz->devices, &devices,
 				sizeof(struct acpi_handle_list))) {
 			memcpy(&tz->devices, &devices,
 				sizeof(struct acpi_handle_list));
-- 
1.8.4.rc0.1.g8f6a3e5.dirty

