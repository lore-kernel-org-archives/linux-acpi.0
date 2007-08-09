From: Len Brown <len.brown@intel.com>
Subject: [PATCH 5/6] ACPI: thermal: add thermal.act= bootparam
Date: Thu,  9 Aug 2007 01:58:55 -0400
Message-ID: <11866391402883-git-send-email-len.brown@intel.com>
References: 11866388361593-git-send-email-len.brown@intel.com
 <11866391363162-git-send-email-len.brown@intel.com>
 <11866391373567-git-send-email-len.brown@intel.com>
 <11866391381018-git-send-email-len.brown@intel.com>
 <11866391391260-git-send-email-len.brown@intel.com>
 <11866391393475-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23497 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765129AbXHIF7B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2007 01:59:01 -0400
In-Reply-To: <11866391393475-git-send-email-len.brown@intel.com>
Message-Id: <131367d2e0318da7feca70b91c2c3c1c47534bed.1186638234.git.len.brown@intel.com>
In-Reply-To: <c405f58ecf5ebf0ba3752cb24a7cd0cc5075646d.1186638234.git.len.brown@intel.com>
References: <c405f58ecf5ebf0ba3752cb24a7cd0cc5075646d.1186638234.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

thermal.act=-1 disables all active trip points
in all ACPI thermal zones.

thermal.act=C, where C > 0, overrides all first active trip points
in all thermal zones to C degrees Celcius.

Note, overriding this trip-point will disable any BIOS attempts
to implement hysterisis around AC0, and may result in the fan
starting and stopping frequently if temperature frequently crosses C.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    4 ++++
 drivers/acpi/thermal.c              |   20 ++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 897bb63..a82d46f 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1820,6 +1820,10 @@ and is between 256 and 4096 characters. It is defined in the file
 	thash_entries=	[KNL,NET]
 			Set number of hash buckets for TCP connection
 
+	thermal.act=	[HW,ACPI]
+			-1: disable all active trip points in all thermal zones
+			<degrees C>: override all lowest active trip points
+
 	thermal.nocrt=	[HW,ACPI]
 			Set to disable actions on ACPI thermal zone
 			critical and hot trip points.
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 1642980..2b48ab9 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
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
@@ -405,11 +409,19 @@ static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 
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
+			/* override last valid trip point */
+			if ((i > 0) && (act > 0))
+				tz->trips.active[i - 1].temperature =
+					CELSIUS_TO_KELVIN(act);
 			break;
+		}
 
 		name[2] = 'L';
 		status =
-- 
1.5.3.rc4.29.g74276
