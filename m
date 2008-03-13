From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH 3/3] [2.6.25-rc5] Warn user about a BIOS bug in recent
	asus boards
Date: Thu, 13 Mar 2008 15:03:07 +0800
Message-ID: <1205391787.2240.71.camel@acpi-hp-zz.sh.intel.com>
References: <1205280392.8194.46.camel@linux-2bdv.site>
	 <200803120010.41373.lenb@kernel.org>  <200803120140.14243.lenb@kernel.org>
	 <1205300688.2240.47.camel@acpi-hp-zz.sh.intel.com>
	 <1205305945.2240.56.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22224 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362AbYCMHPo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Mar 2008 03:15:44 -0400
In-Reply-To: <1205305945.2240.56.camel@acpi-hp-zz.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>, trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>


On Wed, 2008-03-12 at 15:12 +0800, Zhang, Rui wrote:
> On Wed, 2008-03-12 at 13:44 +0800, Zhang, Rui wrote:
> > On Wed, 2008-03-12 at 13:40 +0800, Len Brown wrote:
> > > Actually,
> > > This case (and others)
> > > seems to be taken care of by Rui's recent patch for 8544, yes?
> > > 
> > >  [PATCH] ACPI: thermal fixup for broken BIOS which has invalid trip
> > > points
> > Hah, it doesn't cover the active trip point.
> > 
> > Please review this patch. :)
> After reading the ACPI spec again, 
> "If _PSV is defined then either _PSL or _TZD must be defined. _PSL and
> _TZD may both be defined".
> "_TZD is optional outside of the _PSV requirement".
> which means that we should not throw out an error without checking the
> _TZD method.
> I think the patch still doesn't make sense, please ignore this patch and
> wait for the refreshed patch.. :)
> 
Marton, please try this patch and attach the full dmesg output. :)

According to the ACPI spec, 
"If _PSV is defined then either _PSL or _TZD must be defined.
_PSL and _TZD may both be defined." and
"_TZD is optional outside of the _PSV requirement outlined above".
which means that the passive trip point without _PSL is valid if _TZD exists.

This patch fixes the violation of ACPI spec.

It also fixes a broken BIOS issue which has invalid trip points.
http://bugzilla.kernel.org/show_bug.cgi?id=8544
In this case, the active[0] is set to invalid at boot time
and it will not be re-evaluated again.
We can still get a warning message at boot time.

http://marc.info/?l=linux-kernel&m=120496222629983&w=2

Signed-off-by: Zhang Rui<rui.zhang@intel.com>
---
 drivers/acpi/thermal.c |   76 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 29 deletions(-)

Index: linux-2.6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -400,9 +400,32 @@ static int acpi_thermal_trips_update(str
 		}
 	}
 
+	/* Evaluate _TZD */
+	if (flag & ACPI_TRIPS_DEVICES) {
+		memset(&devices, 0, sizeof(struct acpi_handle_list));
+		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
+						NULL, &devices);
+		if (ACPI_SUCCESS(status)) {
+			tz->flags.devices = 1;
+			if (memcmp(&tz->devices, &devices,
+					sizeof(struct acpi_handle_list))) {
+				memcpy(&tz->devices, &devices,
+					sizeof(struct acpi_handle_list));
+				ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
+			}
+		} else if (tz->flags.devices) {
+			ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
+			tz->flags.devices = 0;
+		}
+	}
+
 	/* Passive (optional) */
-	if (flag & ACPI_TRIPS_PASSIVE) {
+	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES))
 		valid = tz->trips.passive.flags.valid;
+		
+	if (((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) &&
+		(tz->trips.passive.flags.valid || (flag == ACPI_TRIPS_INIT)))
+	{
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
@@ -440,16 +463,20 @@ static int acpi_thermal_trips_update(str
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 							NULL, &devices);
-		if (ACPI_FAILURE(status))
+		if (ACPI_FAILURE(status) &&
+			((status != AE_NOT_FOUND) || !tz->flags.devices)) {
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
@@ -465,7 +492,8 @@ static int acpi_thermal_trips_update(str
 		if (act == -1)
 			break; /* disable all active trip points */
 
-		if (flag & ACPI_TRIPS_ACTIVE) {
+		if ((flag == ACPI_TRIPS_INIT) || ((flag & ACPI_TRIPS_ACTIVE) &&
+			tz->trips.active[i].flags.valid)) {
 			status = acpi_evaluate_integer(tz->device->handle,
 				name, NULL, &tz->trips.active[i].temperature);
 			if (ACPI_FAILURE(status)) {
@@ -497,16 +525,18 @@ static int acpi_thermal_trips_update(str
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
@@ -517,18 +547,6 @@ static int acpi_thermal_trips_update(str
 			break;
 	}
 
-	if (flag & ACPI_TRIPS_DEVICES) {
-		memset(&devices, 0, sizeof(struct acpi_handle_list));
-		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
-						NULL, &devices);
-		if (memcmp(&tz->devices, &devices,
-				sizeof(struct acpi_handle_list))) {
-			memcpy(&tz->devices, &devices,
-				sizeof(struct acpi_handle_list));
-			ACPI_THERMAL_TRIPS_EXCEPTION(flag, "device");
-		}
-	}
-
 	return 0;
 }
 


