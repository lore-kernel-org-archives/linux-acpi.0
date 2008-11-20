From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND] [PATCH] ACPI thermal: only evaluate the valid trip point
	at runtime
Date: Thu, 20 Nov 2008 09:26:01 +0800
Message-ID: <1227144361.15014.266.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41156 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753033AbYKTB0b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Nov 2008 20:26:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, Andi Kleen <andi@firstfloor.org>, nm127@freemail.hu

only evaluate the valid trip points at runtime.

Or else, for the laptops with an invalid trip point,
like the one in http://bugzilla.kernel.org/show_bug.cgi?id=8544
ACPI thermal driver complains every time
when a thermal event 0x81 is received.

http://marc.info/?l=linux-kernel&m=120496222629983&w=2

Signed-off-by: Zhang Rui<rui.zhang@intel.com>
---
 drivers/acpi/thermal.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -416,7 +416,8 @@ static int acpi_thermal_trips_update(str
 	}
 
 	/* Passive (optional) */
-	if (flag & ACPI_TRIPS_PASSIVE) {
+	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.flags.valid) ||
+		(flag == ACPI_TRIPS_INIT)) {
 		valid = tz->trips.passive.flags.valid;
 		if (psv == -1) {
 			status = AE_SUPPORT;
@@ -462,9 +463,11 @@ static int acpi_thermal_trips_update(str
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 							NULL, &devices);
-		if (ACPI_FAILURE(status))
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_WARNING PREFIX
+				"Invalid passive threshold\n");
 			tz->trips.passive.flags.valid = 0;
-		else
+		} else
 			tz->trips.passive.flags.valid = 1;
 
 		if (memcmp(&tz->trips.passive.devices, &devices,
@@ -487,7 +490,8 @@ static int acpi_thermal_trips_update(str
 		if (act == -1)
 			break; /* disable all active trip points */
 
-		if (flag & ACPI_TRIPS_ACTIVE) {
+		if (((flag & ACPI_TRIPS_ACTIVE) && tz->trips.active[i].flags.valid) ||
+			(flag == ACPI_TRIPS_INIT)) {
 			status = acpi_evaluate_integer(tz->device->handle,
 							name, NULL, &tmp);
 			if (ACPI_FAILURE(status)) {
@@ -521,9 +525,11 @@ static int acpi_thermal_trips_update(str
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
 						name, NULL, &devices);
-			if (ACPI_FAILURE(status))
+			if (ACPI_FAILURE(status)) {
+				printk(KERN_WARNING PREFIX
+					"Invalid active%d threshold\n", i);
 				tz->trips.active[i].flags.valid = 0;
-			else
+			} else
 				tz->trips.active[i].flags.valid = 1;
 
 			if (memcmp(&tz->trips.active[i].devices, &devices,


