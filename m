From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/6] ACPI: thermal: add thermal.act= bootparam
Date: Sat, 11 Aug 2007 00:29:30 -0400
Message-ID: <200708110029.31032.lenb@kernel.org>
References: <11866391363162-git-send-email-len.brown@intel.com> <11866391393475-git-send-email-len.brown@intel.com> <11866391402883-git-send-email-len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39079 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbXHKE3f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Aug 2007 00:29:35 -0400
Received: from d975xbx2 (WPIS-64-140-212-33.worldpath.net [64.140.212.33])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id l7B4TWcY000431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sat, 11 Aug 2007 04:29:33 GMT
In-Reply-To: <11866391402883-git-send-email-len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Subject: ACPI: thermal: create "thermal.act=" to disable or override active trip point

From: Len Brown <len.brown@intel.com>

thermal.act=-1 disables all active trip points
in all ACPI thermal zones.

thermal.act=C, where C > 0, overrides all lowest temperature
active trip points in all thermal zones to C degrees Celsius.
Raising this trip-point may allow you to keep your system silent
up to a higher temperature.  However, it will not allow you to
raise the lowest temperature trip point above the next higher
trip point (if there is one).  Lowering this trip point may
kick in the fan sooner.

Note that overriding this trip-point will disable any BIOS attempts
to implement hysteresis around the lowest temperature trip point.
This may result in the fan starting and stopping frequently
if temperature frequently crosses C.

WARNING: raising trip points above the manufacturer's defaults
may cause the system to run at higher temperature and shorten
its life.

Signed-off-by: Len Brown <len.brown@intel.com>
---

refreshed to add check to limit trip-point override
to equal the next higher trip point.

Index: linus/Documentation/kernel-parameters.txt
===================================================================
--- linus.orig/Documentation/kernel-parameters.txt
+++ linus/Documentation/kernel-parameters.txt
@@ -1820,6 +1820,10 @@ and is between 256 and 4096 characters. 
 	thash_entries=	[KNL,NET]
 			Set number of hash buckets for TCP connection
 
+	thermal.act=	[HW,ACPI]
+			-1: disable all active trip points in all thermal zones
+			<degrees C>: override all lowest active trip points
+
 	thermal.nocrt=	[HW,ACPI]
 			Set to disable actions on ACPI thermal zone
 			critical and hot trip points.
Index: linus/drivers/acpi/thermal.c
===================================================================
--- linus.orig/drivers/acpi/thermal.c
+++ linus/drivers/acpi/thermal.c
@@ -74,6 +74,10 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Thermal Zone Driver");
 MODULE_LICENSE("GPL");
 
+static int act;
+module_param(act, int, 0644);
+MODULE_PARM_DESC(act, "Disable or override all lowest active trip points.\n");
+
 static int tzp;
 module_param(tzp, int, 0444);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.\n");
@@ -405,11 +409,33 @@ static int acpi_thermal_get_trip_points(
 
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
 
-		status =
-		    acpi_evaluate_integer(tz->device->handle, name, NULL,
-					  &tz->trips.active[i].temperature);
-		if (ACPI_FAILURE(status))
+		if (act == -1)
+			break;	/* disable all active trip points */
+
+		status = acpi_evaluate_integer(tz->device->handle,
+			name, NULL, &tz->trips.active[i].temperature);
+
+		if (ACPI_FAILURE(status)) {
+			if (i == 0)	/* no active trip points */
+				break;
+			if (act <= 0)	/* no override requested */
+				break;
+			if (i == 1) {	/* 1 trip point */
+				tz->trips.active[0].temperature =
+					CELSIUS_TO_KELVIN(act);
+			} else {	/* multiple trips */
+				/*
+				 * Don't allow override higher than
+				 * the next higher trip point
+				 */
+				tz->trips.active[i - 1].temperature =
+				    (tz->trips.active[i - 2].temperature <
+					CELSIUS_TO_KELVIN(act) ?
+					tz->trips.active[i - 2].temperature :
+					CELSIUS_TO_KELVIN(act));
+			}
 			break;
+		}
 
 		name[2] = 'L';
 		status =
