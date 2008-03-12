From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/3] [2.6.25-rc5] Warn user about a BIOS bug in recent asus
	boards
Date: Wed, 12 Mar 2008 01:06:32 +0100
Message-ID: <1205280392.8194.46.camel@linux-2bdv.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:44840 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbYCLAGU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 20:06:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Warn user about a BIOS bug in recent asus boards

Do copy passive devices only if they are valid.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>

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




