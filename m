From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/6] ACPI: thermal: create "thermal.psv=" bootparam
Date: Thu, 9 Aug 2007 13:22:03 -0400
Message-ID: <200708091322.03640.lenb@kernel.org>
References: <11866391363162-git-send-email-len.brown@intel.com> <11866391381018-git-send-email-len.brown@intel.com> <11866391391260-git-send-email-len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39595 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934322AbXHIRWL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2007 13:22:11 -0400
Received: from d975xbx2 (WPIS-64-140-212-33.worldpath.net [64.140.212.33])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id l79HM4P6023205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Thu, 9 Aug 2007 17:22:08 GMT
In-Reply-To: <11866391391260-git-send-email-len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Subject: ACPI: thermal: create "thermal.psv=" to override passive trip points

From: Len Brown <len.brown@intel.com>

"thermal.psv=-1" disables passive trip points
for all ACPI thermal zones.

"thermal.psv=C", where 'C' is degrees Celsius,
overrides all existing passive trip points
for all ACPI thermal zones.

thermal.psv is checked at module load time,
and in response to trip-point change events.

Note that if the system does not deliver thermal zone
temperature change events near the new trip-point,
then it will not be noticed.  To force your custom
trip point to be noticed, you may need to enable polling:
eg. thermal.tzp=3000 invokes polling every 5 minutes.

Note that once passive thermal throttling is invoked,
it has its own internal Thermal Sampling Period (_TSP),
that is unrelated to _TZP.

WARNING: disabling or raising a thermal trip point
may result in increased running temperature and
shorter hardware lifetime on some systems.

Signed-off-by: Len Brown <len.brown@intel.com>
---

This updates the previous version of this patch
so that -1 disables _PSV (instead of 0),
and the user's Celsius value is properly converted
to Kelvin*10 for internal use.

Index: linus/Documentation/kernel-parameters.txt
===================================================================
--- linus.orig/Documentation/kernel-parameters.txt
+++ linus/Documentation/kernel-parameters.txt
@@ -1823,6 +1823,10 @@ and is between 256 and 4096 characters. 
 	thermal.off=	[HW,ACPI]
 			1: disable ACPI thermal control
 
+	thermal.psv=	[HW,ACPI]
+			-1: disable all passive trip points
+			<degrees C>: override all passive trip points to this value
+
 	thermal.tzp=	[HW,ACPI]
 			Specify global default ACPI thermal zone polling rate
 			<deci-seconds>: poll all this frequency
Index: linus/drivers/acpi/thermal.c
===================================================================
--- linus.orig/drivers/acpi/thermal.c
+++ linus/drivers/acpi/thermal.c
@@ -82,6 +82,10 @@ static int off;
 module_param(off, int, 0);
 MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.\n");
 
+static int psv;
+module_param(psv, int, 0644);
+MODULE_PARM_DESC(psv, "Disable or override all passive trip points.\n");
+
 static int acpi_thermal_add(struct acpi_device *device);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
 static int acpi_thermal_resume(struct acpi_device *device);
@@ -343,9 +347,16 @@ static int acpi_thermal_get_trip_points(
 
 	/* Passive: Processors (optional) */
 
-	status =
-	    acpi_evaluate_integer(tz->device->handle, "_PSV", NULL,
-				  &tz->trips.passive.temperature);
+	if (psv == -1) {
+		status = AE_SUPPORT;
+	} else if (psv > 0) {
+		tz->trips.passive.temperature = CELSIUS_TO_KELVIN(psv);
+		status = AE_OK;
+	} else {
+		status = acpi_evaluate_integer(tz->device->handle,
+			"_PSV", NULL, &tz->trips.passive.temperature);
+	}
+
 	if (ACPI_FAILURE(status)) {
 		tz->trips.passive.flags.valid = 0;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No passive threshold\n"));
