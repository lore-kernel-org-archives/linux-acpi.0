From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Do copy passive devices only if they are valid
Date: Thu, 06 Mar 2008 23:33:47 +0100
Message-ID: <1204842827.8741.7.camel@linux-2bdv.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:48726 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758816AbYCFWdl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Mar 2008 17:33:41 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ming.m.lin@intel.com
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Warn user about a BIOS bug in recent asus boards

Do copy passive devices only if they are valid.

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/thermal.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

Index: linux-2.6.24/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.24.orig/drivers/acpi/thermal.c
+++ linux-2.6.24/drivers/acpi/thermal.c
@@ -440,16 +440,18 @@ static int acpi_thermal_trips_update(str
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 							NULL, &devices);
-		if (ACPI_FAILURE(status))
-			tz->trips.passive.flags.valid = 0;
-		else
+		if (ACPI_SUCCESS(status)) {
 			tz->trips.passive.flags.valid = 1;
-
-		if (memcmp(&tz->trips.passive.devices, &devices,
-				sizeof(struct acpi_handle_list))) {
-			memcpy(&tz->trips.passive.devices, &devices,
-				sizeof(struct acpi_handle_list));
-			ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
+			if (memcmp(&tz->trips.passive.devices, &devices,
+				   sizeof(struct acpi_handle_list))) {
+				memcpy(&tz->trips.passive.devices, &devices,
+				       sizeof(struct acpi_handle_list));
+				ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
+			}
+		} else {
+			tz->trips.passive.flags.valid = 0;
+			ACPI_EXCEPTION((AE_INFO, status, "Invalid passiv trip"
+					" point\n"));
 		}
 	}
 	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {


