From: Len Brown <len.brown@intel.com>
Subject: [PATCH 3/6] ACPI: thermal: create "thermal.psv=" bootparam
Date: Thu,  9 Aug 2007 01:58:53 -0400
Message-ID: <11866391391260-git-send-email-len.brown@intel.com>
References: 11866388361593-git-send-email-len.brown@intel.com
 <11866391363162-git-send-email-len.brown@intel.com>
 <11866391373567-git-send-email-len.brown@intel.com>
 <11866391381018-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23487 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759469AbXHIF7A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2007 01:59:00 -0400
In-Reply-To: <11866391381018-git-send-email-len.brown@intel.com>
Message-Id: <95fa38b440b56d248ad09a75d1187310527e7b17.1186638234.git.len.brown@intel.com>
In-Reply-To: <c405f58ecf5ebf0ba3752cb24a7cd0cc5075646d.1186638234.git.len.brown@intel.com>
References: <c405f58ecf5ebf0ba3752cb24a7cd0cc5075646d.1186638234.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

"thermal.psv=0" disables passive trip points
for all ACPI thermal zones.

"thermal.psv=C", where 'C' is degrees Celcius,
overrides existing passive trip points
for all ACPI thermal zones.

thermal.psv is checked at module load time,
and in response to trip-point change events.

Note that if the system does not deliver thermal zone
temperature change events near the new trip-point,
then it will not be noticed.  To force it to be
noticed, you can enable polling:
eg. thermal.tzp=3000 invokes polling every 5 minutes.

Note that once passive thermal throttling is invoked,
it has its own internal polling frequencey that is
independent of tzp.

WARNING: disabling or raising a thermal trip point
will result in increased running temperature and
shorter hardware lifetime on some systems.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    4 ++++
 drivers/acpi/thermal.c              |   17 ++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 2c21ed4..9118fc6 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1823,6 +1823,10 @@ and is between 256 and 4096 characters. It is defined in the file
 	thermal.off=	[HW,ACPI]
 			1: disable ACPI thermal control
 
+	thermal.psv=	[HW,ACPI]
+			0: disable all passive trip points
+			<degrees C>: override all passive trip points to this value
+
 	thermal.tzp=	[HW,ACPI]
 			Specify global default ACPI thermal zone polling rate
 			<deci-seconds>: poll all this frequency
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index b6b3bec..9d7453c 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -82,6 +82,10 @@ static int off;
 module_param(off, int, 0);
 MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.\n");
 
+static int psv = -1;
+module_param(psv, int, 0644);
+MODULE_PARM_DESC(psv, "Disable or override all passive trip points.\n");
+
 static int acpi_thermal_add(struct acpi_device *device);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
 static int acpi_thermal_resume(struct acpi_device *device);
@@ -343,9 +347,16 @@ static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 
 	/* Passive: Processors (optional) */
 
-	status =
-	    acpi_evaluate_integer(tz->device->handle, "_PSV", NULL,
-				  &tz->trips.passive.temperature);
+	if (psv == 0) {
+		status = AE_SUPPORT;
+	} else if (psv > 0) {
+		tz->trips.passive.temperature = psv;
+		status = AE_OK;
+	} else {
+		status = acpi_evaluate_integer(tz->device->handle,
+			"_PSV", NULL, &tz->trips.passive.temperature);
+	}
+
 	if (ACPI_FAILURE(status)) {
 		tz->trips.passive.flags.valid = 0;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No passive threshold\n"));
-- 
1.5.3.rc4.29.g74276
