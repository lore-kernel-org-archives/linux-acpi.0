From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH 3/3] [2.6.25-rc5] Warn user about a BIOS bug in recent
	asus boards
Date: Wed, 12 Mar 2008 13:44:48 +0800
Message-ID: <1205300688.2240.47.camel@acpi-hp-zz.sh.intel.com>
References: <1205280392.8194.46.camel@linux-2bdv.site>
	 <200803120010.41373.lenb@kernel.org>  <200803120140.14243.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18192 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbYCLF5T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 01:57:19 -0400
In-Reply-To: <200803120140.14243.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>


On Wed, 2008-03-12 at 13:40 +0800, Len Brown wrote:
> Actually,
> This case (and others)
> seems to be taken care of by Rui's recent patch for 8544, yes?
> 
>  [PATCH] ACPI: thermal fixup for broken BIOS which has invalid trip
> points
Hah, it doesn't cover the active trip point.

Please review this patch. :)

Marton,
It would be really great if you can try this refreshed patch and attach
the full dmesg output.

thanks,
rui

subject:thermal fixup for broken BIOS which has invalid trip points.

ACPI thermal driver only re-evaluate valid trip points.
For the broken BIOS show in
http://bugzilla.kernel.org/show_bug.cgi?id=8544
the active[0] is set to invalid at boot time
and it will not be re-evaluated again.
We can still get a warning message at boot time.

http://marc.info/?l=linux-kernel&m=120496222629983&w=2

Signed-off-by: Zhang Rui<rui.zhang@intel.com>
---
 drivers/acpi/thermal.c |   41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -401,7 +401,8 @@ static int acpi_thermal_trips_update(str
 	}
 
 	/* Passive (optional) */
-	if (flag & ACPI_TRIPS_PASSIVE) {
+	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.flags.valid) ||
+		(flag == ACPI_TRIPS_INIT)) {
 		valid = tz->trips.passive.flags.valid;
 		if (psv == -1) {
 			status = AE_SUPPORT;
@@ -440,16 +441,19 @@ static int acpi_thermal_trips_update(str
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 							NULL, &devices);
-		if (ACPI_FAILURE(status))
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_WARNING PREFIX
+				"Invalid passive threshold\n");
 			tz->trips.passive.flags.valid = 0;
-		else
+		} else {
 			tz->trips.passive.flags.valid = 1;
 
-		if (memcmp(&tz->trips.passive.devices, &devices,
-				sizeof(struct acpi_handle_list))) {
-			memcpy(&tz->trips.passive.devices, &devices,
-				sizeof(struct acpi_handle_list));
-			ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
+			if (memcmp(&tz->trips.passive.devices, &devices,
+					sizeof(struct acpi_handle_list))) {
+				memcpy(&tz->trips.passive.devices, &devices,
+					sizeof(struct acpi_handle_list));
+				ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
+			}
 		}
 	}
 	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
@@ -465,7 +469,8 @@ static int acpi_thermal_trips_update(str
 		if (act == -1)
 			break; /* disable all active trip points */
 
-		if (flag & ACPI_TRIPS_ACTIVE) {
+		if ((flag == ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE) &&
+			tz->trips.active[i].flags.valid)) {
 			status = acpi_evaluate_integer(tz->device->handle,
 				name, NULL, &tz->trips.active[i].temperature);
 			if (ACPI_FAILURE(status)) {
@@ -497,16 +502,18 @@ static int acpi_thermal_trips_update(str
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
 						name, NULL, &devices);
-			if (ACPI_FAILURE(status))
+			if (ACPI_FAILURE(status)) {
+				printk(KERN_WARNING PREFIX
+					"Invalid active%d threshold\n", i);
 				tz->trips.active[i].flags.valid = 0;
-			else
+			} else {
 				tz->trips.active[i].flags.valid = 1;
-
-			if (memcmp(&tz->trips.active[i].devices, &devices,
-					sizeof(struct acpi_handle_list))) {
-				memcpy(&tz->trips.active[i].devices, &devices,
-					sizeof(struct acpi_handle_list));
-				ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
+				if (memcmp(&tz->trips.active[i].devices, &devices,
+						sizeof(struct acpi_handle_list))) {
+					memcpy(&tz->trips.active[i].devices, &devices,
+						sizeof(struct acpi_handle_list));
+					ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
+				}
 			}
 		}
 		if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))


